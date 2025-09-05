// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_pointer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PublisherPointerAdapter extends TypeAdapter<PublisherPointer> {
  @override
  final int typeId = 11;

  @override
  PublisherPointer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublisherPointer(
      name: fields[0] as String,
      file: fields[1] as String,
      otherversions: (fields[2] as List).cast<OtherVersion>(),
    );
  }

  @override
  void write(BinaryWriter writer, PublisherPointer obj) {
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
      other is PublisherPointerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
