// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_json.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NestMetaAdapter extends TypeAdapter<NestMeta> {
  @override
  final int typeId = 11;

  @override
  NestMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NestMeta(
      name: fields[0] as String,
      file: fields[1] as String,
      otherversions: (fields[2] as List).cast<OtherVersion>(),
    );
  }

  @override
  void write(BinaryWriter writer, NestMeta obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.otherversions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NestMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
