// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceAdapter extends TypeAdapter<Publisher> {
  @override
  final int typeId = 4;

  @override
  Publisher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Publisher(
      id: fields[0] as String,
      name: fields[1] as String,
      homePage: fields[2] as String,
      hasSearchSupport: fields[3] as bool,
      hasCustomSupport: fields[4] as bool,
      iconUrl: fields[5] as String,
      siteCategories: (fields[6] as List).cast<String>(),
      metadata: fields[7] as PublisherMetadata?,
    )..otherVersions = (fields[8] as List).cast<Publisher>();
  }

  @override
  void write(BinaryWriter writer, Publisher obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.homePage)
      ..writeByte(3)
      ..write(obj.hasSearchSupport)
      ..writeByte(4)
      ..write(obj.hasCustomSupport)
      ..writeByte(5)
      ..write(obj.iconUrl)
      ..writeByte(6)
      ..write(obj.siteCategories)
      ..writeByte(7)
      ..write(obj.metadata)
      ..writeByte(8)
      ..write(obj.otherVersions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publisher _$SourceFromJson(Map<String, dynamic> json) => Publisher(
      id: json['id'] as String,
      name: json['name'] as String,
      homePage: json['homePage'] as String,
      hasSearchSupport: json['hasSearchSupport'] as bool,
      hasCustomSupport: json['hasCustomSupport'] as bool,
      iconUrl: json['iconUrl'] as String,
      siteCategories: (json['siteCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: json['externalSource'] == null
          ? null
          : PublisherMetadata.fromJson(
              json['externalSource'] as Map<String, dynamic>),
    )..otherVersions = (json['otherVersions'] as List<dynamic>)
        .map((e) => Publisher.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$SourceToJson(Publisher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'homePage': instance.homePage,
      'hasSearchSupport': instance.hasSearchSupport,
      'hasCustomSupport': instance.hasCustomSupport,
      'iconUrl': instance.iconUrl,
      'siteCategories': instance.siteCategories,
      'externalSource': instance.metadata,
      'otherVersions': instance.otherVersions,
    };
