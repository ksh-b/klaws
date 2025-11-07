import 'dart:convert';
import 'dart:io';

import 'package:klaws/model/pointers/pointers.dart';
import 'package:klaws/model/publisher/publisher.dart';
import 'package:klaws/model/publisher/metadata.dart';
import 'package:klaws/model/repo.dart';
import 'package:klaws/model/watch/watch.dart';
import 'package:klaws/util/util.dart';

class ZipSource extends Repo {
  ZipSource(super.url);

  @override
  Future<RepoMetadata> setup({String path = "."}) async {
    var repoMetadata = await downloadAndExtractZip(url, path);
    final pointersFile = File("$path/${repoMetadata.zipFolder}/sources.json");
    String pointersJson = await pointersFile.readAsString();
    var pointers = Pointers.fromJson(json.decode(pointersJson));
    var publishers = [];
    var publisherPointers = pointers.publisherPointers;
    for (var ptr in publisherPointers) {
      final file = File("$path/${ptr.file}");
      String jsonString = await file.readAsString();
      PublisherMetadata publisherMetadata = PublisherMetadata.fromJson(json.decode(jsonString));
      Publisher publisher = Publisher(
        id: base64Encode(utf8.encode(url)),
        hasCustomSupport: publisherMetadata.supportsCustomCategory,
        metadata: publisherMetadata,
        hasSearchSupport: publisherMetadata.searchUrl.isNotEmpty,
        homePage: publisherMetadata.homePage,
        iconUrl: publisherMetadata.iconUrl,
        name: publisherMetadata.name,
        siteCategories: publisherMetadata.category,
      );
      publishers.add(publisher);
    }

    var watchPointers = pointers.watchPointers;
    for (var watch in watchPointers) {
      final file = File("$path/${watch.file}");
      String jsonString = await file.readAsString();
      Watch.fromJson(json.decode(jsonString));
    }

    return repoMetadata;

  }

}


class RepoMetadata {
  final String name;
  final String description;
  final String icon;
  final String zipUrl;
  final String zipFolder;

  RepoMetadata({
    required this.name,
    required this.description,
    required this.icon,
    required this.zipUrl,
    required this.zipFolder,
  });

  factory RepoMetadata.fromJson(Map<String, dynamic> json) => RepoMetadata(
    name: json['name'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
    zipUrl: json['zip-url'] as String,
    zipFolder: json['zip-folder'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'icon': icon,
    'zip-url': zipUrl,
    'zip-folder': zipFolder,
  };
}
