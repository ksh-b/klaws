import 'package:hive_ce/hive.dart';

import '../publisher/other_version.dart';

part 'publisher_pointer.g.dart';

@HiveType(typeId: 11)

// publishers.json
class PublisherPointer {
  @HiveField(0)
  String name = "";
  @HiveField(1)
  String file = "";
  @HiveField(2)
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
