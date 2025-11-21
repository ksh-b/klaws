// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Watch _$WatchFromJson(Map<String, dynamic> json) => Watch(
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  url: json['url'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => Option.fromJson(e as Map<String, dynamic>))
      .toList(),
  items: json['items'] == null
      ? null
      : Items.fromJson(json['items'] as Map<String, dynamic>),
)..id = (json['id'] as num).toInt();

Map<String, dynamic> _$WatchToJson(Watch instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'url': instance.url,
  'options': instance.options,
  'items': instance.items,
};
