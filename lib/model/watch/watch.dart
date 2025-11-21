// Watch from JSON files
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'watch.g.dart';

@JsonSerializable()
class Watch {
  int id = 0;
  String name="";
  String description="";
  String category="";
  String url="";
  List<Option> options=[];
  Items? items;

  Watch({
    required this.name,
    required this.description,
    required this.category,
    required this.url,
    required this.options,
    required this.items,
  });

  factory Watch.fromJson(Map<String, dynamic> json) {
    return Watch(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      url: json['url'] ?? '',
      options: (json['options'] as List?)
          ?.map((option) => Option.fromJson(option))
          .toList() ?? [],
      items: json['items'] != null ? Items.fromJson(json['items']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'url': url,
      'options': options.map((option) => option.toJson()).toList(),
      'items': items?.toJson(),
    };
  }

  @override
  String toString() => json.encode(toJson());
}

class Items {
  String extractor;
  String title;
  String subtitle;
  Ing leading;
  Ing trailing;
  String thumbnail;
  List<String> notes;
  String url;

  Items({
    required this.extractor,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    required this.thumbnail,
    required this.notes,
    required this.url,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      extractor: json['extractor'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      leading: Ing.fromJson(json['leading']),
      trailing: Ing.fromJson(json['trailing']),
      thumbnail: json['thumbnail'] ?? '',
      notes: (json['notes'] as List?)
          ?.map((note) => note.toString())
          .toList() ?? [],
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extractor': extractor,
      'title': title,
      'subtitle': subtitle,
      'leading': leading.toJson(),
      'trailing': trailing.toJson(),
      'thumbnail': thumbnail,
      'notes': notes,
      'url': url,
    };
  }

}

class Ing {
  String top;
  String bottom;

  Ing({
    required this.top,
    required this.bottom,
  });

  factory Ing.fromJson(Map<String, dynamic> json) {
    return Ing(
      top: json['top'] ?? '',
      bottom: json['bottom'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'bottom': bottom,
    };
  }

}

class Option {
  String name;
  String description;
  String example;

  Option({
    required this.name,
    required this.description,
    required this.example,
  });


  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      example: json['example'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'example': example,
    };
  }

}
