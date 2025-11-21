import 'dart:convert';

import 'package:objectbox/objectbox.dart';

class OtherVersion {
  int id = 0;
  String name = "";
  String file = "";

  OtherVersion({
    required this.name,
    required this.file,
  });

  OtherVersion.fromJson(dynamic json) {
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['file'] = file;
    return map;
  }

  @override
  String toString() => json.encode(toJson());
}
