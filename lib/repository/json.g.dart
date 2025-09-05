// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JsonSourceAdapter extends TypeAdapter<PublisherFromJson> {
  @override
  final int typeId = 14;

  @override
  PublisherFromJson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublisherFromJson(
      id: fields[0] as String,
      name: fields[1] as String,
      homePage: fields[2] as String,
      hasSearchSupport: fields[3] as bool,
      hasCustomSupport: fields[4] as bool,
      iconUrl: fields[5] as String,
      siteCategories: (fields[6] as List).cast<String>(),
      metadata: fields[7] as JsonMetadata?,
    )..otherVersions = (fields[8] as List).cast<Publisher>();
  }

  @override
  void write(BinaryWriter writer, PublisherFromJson obj) {
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
      other is JsonSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
