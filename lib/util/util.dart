import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:intl/intl.dart';
import 'package:json_path/json_path.dart';
import 'package:klaws/model/publisher/metadata.dart';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

import '../repository/zip.dart';

int getEpochTimeFromElement(PublisherMetadata source, String dateFormat, Element? dateElement) {
  var epoch = -1;
  if(dateElement==null) {
    return epoch;
  }
  var timestamp = dateElement.attributes.entries.where(
    (entry) => entry.key.toString().contains("datetime")||entry.key.toString().contains("timestamp")
  ).firstOrNull;

  if (timestamp!=null) {
    if (timestamp.key.toString().contains("datetime")) {
      return getEpochTimeFromString(dateFormat, timestamp.value).toInt();
    } else {
      if(double.tryParse(timestamp.value) != null) {
        return getEpochTimeFromString(dateFormat, timestamp.value).toInt();
      }
    }
  }
  return getEpochTimeFromString(dateFormat, dateElement.text).toInt();
}

num relativeStringToUnix(String timeString) {
  try {
    if (timeString.contains("ago")) {
      if (timeString.startsWith("a ")) {
        timeString = timeString.replaceFirst("a ", "1 ");
      }
    }
    List<String> words = timeString.split(' ');
    int value = int.parse(words[0]);
    String unit = words[1].toLowerCase();
    int seconds;
    switch (unit) {
      case 'sec':
      case 'second':
      case 'seconds':
        seconds = value;
        break;
      case 'min':
      case 'minute':
      case 'minutes':
        seconds = value * 60;
        break;
      case 'hour':
      case 'hours':
        seconds = value * 3600;
        break;

      default:
        seconds = 0;
    }
    return DateTime.now().subtract(Duration(seconds: seconds)).millisecondsSinceEpoch / 1000;
  } catch (e) {
    return -1;
  }
}

int getEpochTimeFromString(String dateFormat, String dateString) {
  var epoch = -1;
  if (dateString.isEmpty) {
    return epoch;
  }

  dateString = dateString.replaceAll(RegExp(r'(st|nd|rd|th)'), '');
  if (dateFormat == "ISO 8601") {
    return (DateTime.parse(dateString).millisecondsSinceEpoch / 1000).toInt();
  }
  if (dateFormat == "Unix Epoch") {
    var maybeEpoch = int.tryParse(dateString);
    if(maybeEpoch!=null) {
      if (dateString.length == 13) { // milliseconds
        return maybeEpoch;
      }
      if (dateString.length == 10) { // seconds
        return maybeEpoch * 1000;
      }
      if (dateString.length == 16) { // microseconds
        return (maybeEpoch / 1000).toInt();
      }
    }
  }
  if (dateFormat == "relative") {
    relativeStringToUnix(dateString);
  }
  if(dateString.isEmpty) {
    return epoch;
  }
  if (dateFormat.isNotEmpty) {
    try {
      epoch = (DateFormat(dateFormat)
          .parse(dateString)
          .millisecondsSinceEpoch /
          1000).toInt();
    } catch (e) {
      // todo : log info
    }
  } else if (epoch == -1.0 &&
      dateString.toLowerCase().contains("yesterday")) {
    try {
      epoch =
          (DateTime
              .now()
              .subtract(Duration(days: 1))
              .millisecondsSinceEpoch /
              1000).toInt();
    } catch (e) {
      // todo : log info
    }
  }
  return epoch;
}

String completeUrl (PublisherMetadata source, String url, {String? category}) {
  if(!url.startsWith("http") && !url.contains(source.homePage)) {
    if (!url.startsWith("/")) {
      url = "/$url";
    }
    url = "${source.homePage}$url";
  }
  return url;
}

Future<Response<dynamic>> getResponse(PublisherMetadata source, String url, Dio dio) async {
  Map<String, List<String>> responseHeaders = {};
  if(source.headers.json_.containsKey("Cookie")) {
    if(source.headers.json_["Cookie"].isEmpty) {
      responseHeaders = await dio.get(
        source.homePage,
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (status) => true,
        ),
      ).then((value) => value.headers.map);
    }
  }


  Map<String, dynamic> requestHeaders = source.headers.json_;
  if (responseHeaders.isNotEmpty && responseHeaders.containsKey("set-cookie")) {
    requestHeaders['Cookie'] = responseHeaders["set-cookie"];
  }

  final response = await dio.get(
    url,
    options: Options(
      headers: requestHeaders,
      validateStatus: (status) => true,
    ),
  );
  return response;
}


extension OptionalElement on Element {
  Element? querySelectorOptional(String selector) {
    if (selector.isEmpty) {
      return null;
    } else {
      return querySelector(selector);
    }
  }

  List<Element>? querySelectorAllOptional(String selector) {
    if (selector.isEmpty) {
      return null;
    } else {
      return querySelectorAll(selector);
    }
  }
}

extension OptionalDocument on Document {
  Element? querySelectorOptional(String selector) {
    if (selector.isEmpty) {
      return null;
    } else {
      return querySelector(selector);
    }
  }

  List<Element>? querySelectorAllOptional(String selector) {
    if (selector.isEmpty) {
      return null;
    } else {
      return querySelectorAll(selector);
    }
  }
}

extension FirstJsonPath on JsonPath {
  List<String> asList(dynamic json) {
    return read(json).map((match) => '${match.value}').toList();
  }
}

Future<RepoMetadata> downloadAndExtractZip(String metadataUrl, String outputDirectory) async {
  // Initialize Dio
  final dio = Dio();
  final RepoMetadata metadata;

  // Create the output directory if it doesn't exist
  Directory(outputDirectory).createSync(recursive: true);
  try {

    var response = await dio.get(metadataUrl);
    if (response.statusCode != 200) {
      throw Exception('Failed to connect to $metadataUrl');
    }

    final data = response.data;
    final Map<String, dynamic> json = jsonDecode(data);
    metadata = RepoMetadata.fromJson(json);

    // Download the ZIP file
    response = await dio.get(metadata.zipUrl, options: Options(responseType: ResponseType.bytes));
    final bytes = response.data;

    // Save the ZIP file to a temporary location
    final tempZipFile = File(path.join(outputDirectory, 'temp.zip'));
    await tempZipFile.writeAsBytes(bytes);

    // Extract the ZIP file
    final archive = ZipDecoder().decodeBytes(bytes);
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final outputFilePath = path.join(outputDirectory, filename);
        final outputFile = File(outputFilePath);
        final outputDirPath = path.dirname(outputFilePath);
        Directory(outputDirPath).createSync(recursive: true);
        await outputFile.writeAsBytes(file.content);
      } else {
        final outputDirPath = path.join(outputDirectory, filename);
        Directory(outputDirPath).createSync(recursive: true);
      }
    }

    await tempZipFile.delete();
    return metadata;
  } catch (e) {
    throw Exception('Failed to download or extract ZIP file: $e');
  }
}
