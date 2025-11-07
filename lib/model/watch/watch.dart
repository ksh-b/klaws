
import 'package:hive_ce/hive.dart';

part 'watch.g.dart';

// Watch from JSON files
@HiveType(typeId: 16)
class Watch {
  @HiveField(0)
  String name="";
  @HiveField(1)
  String description="";
  @HiveField(2)
  String category="";
  @HiveField(3)
  String url="";
  @HiveField(4)
  List<Option> options=[];
  @HiveField(5)
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

}

@HiveType(typeId: 21)
class Items {
  @HiveField(0)
  String extractor;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  Ing leading;
  @HiveField(4)
  Ing trailing;
  @HiveField(5)
  String thumbnail;
  @HiveField(6)
  List<String> notes;
  @HiveField(7)
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

@HiveType(typeId: 19)
class Ing {
  @HiveField(0)
  String top;
  @HiveField(1)
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

@HiveType(typeId: 18)
class Option {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String optionDefault;

  Option({
    required this.name,
    required this.description,
    required this.optionDefault,
  });


  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      optionDefault: json['optionDefault'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'optionDefault': optionDefault,
    };
  }

}
