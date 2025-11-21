import 'package:objectbox/objectbox.dart';

class WatchPointer {
  int id = 0;
  String name = "";
  String file = "";

  WatchPointer({
    required this.name,
    required this.file,
  });

  WatchPointer.fromJson(dynamic json) {
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['file'] = file;
    return map;
  }
}
