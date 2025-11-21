import 'package:objectbox/objectbox.dart';
import '../publisher/other_version.dart';

// publishers.json
class PublisherPointer {
  int id = 0;
  String name = "";
  String file = "";
  List<OtherVersion> otherversions = [];

  PublisherPointer({
    required this.name,
    required this.file,
    required this.otherversions,
  });

  PublisherPointer.fromJson(dynamic json) {
    name = json['name'];
    file = json['file'];
    if (json['other-versions'] != null) {
      otherversions = [];
      json['other-versions'].forEach((v) {
        otherversions.add(OtherVersion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['file'] = file;
    map['other-versions'] = otherversions.map((v) => v.toJson()).toList();
      return map;
  }

}
