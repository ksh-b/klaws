import 'package:klaws/model/source/watch_pointer.dart';

import 'publisher_pointer.dart';

class Pointers {
  String name = "";
  String description = "";
  String changelog = "";
  List<PublisherPointer> publisherPointers = [];
  List<WatchPointer> watchPointers = [];

  Pointers({
    required this.name,
    required this.description,
    required this.changelog,
    required this.publisherPointers,
    required this.watchPointers,
  });

  Pointers.fromJson(dynamic json_) {
    name = json_['name'];
    description = json_['description'];
    changelog = json_['changelog'];
    if (json_['publishers'] != null) {
      publisherPointers = [];
      json_['publishers'].forEach((v) {
        publisherPointers.add(PublisherPointer.fromJson(v));
      });
    }
    if (json_['watches'] != null) {
      watchPointers = [];
      json_['watches'].forEach((v) {
        watchPointers.add(WatchPointer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['changelog'] = changelog;
    map['publishers'] = publisherPointers.map((v) => v.toJson()).toList();
      return map;
  }
}
