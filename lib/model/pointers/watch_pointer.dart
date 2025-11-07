import 'package:hive_ce/hive.dart';

part 'watch_pointer.g.dart';

@HiveType(typeId: 16)
class WatchPointer {
  @HiveField(0)
  String name = "";
  @HiveField(1)
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
