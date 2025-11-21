// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publisher _$PublisherFromJson(Map<String, dynamic> json) =>
    Publisher(
        id: json['id'] as String,
        name: json['name'] as String,
        homePage: json['homePage'] as String,
        hasSearchSupport: json['hasSearchSupport'] as bool,
        hasCustomSupport: json['hasCustomSupport'] as bool,
        iconUrl: json['iconUrl'] as String,
        siteCategories: (json['siteCategories'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        metadata: json['metadata'] == null
            ? null
            : PublisherMetadata.fromJson(
                json['metadata'] as Map<String, dynamic>,
              ),
      )
      ..otherVersions = (json['otherVersions'] as List<dynamic>)
          .map((e) => Publisher.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'homePage': instance.homePage,
  'hasSearchSupport': instance.hasSearchSupport,
  'hasCustomSupport': instance.hasCustomSupport,
  'iconUrl': instance.iconUrl,
  'siteCategories': instance.siteCategories,
  'metadata': instance.metadata,
  'otherVersions': instance.otherVersions,
};
