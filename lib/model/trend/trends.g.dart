// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trends _$TrendsFromJson(Map<String, dynamic> json) => Trends(
  extractor: json['extractor'] as String,
  locator: json['locator'] as String,
  name: json['name'] as String,
  favicon: json['favicon'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$TrendsToJson(Trends instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
  'extractor': instance.extractor,
  'favicon': instance.favicon,
  'locator': instance.locator,
};
