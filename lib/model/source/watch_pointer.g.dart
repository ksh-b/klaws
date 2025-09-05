// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_pointer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExternalWatchMetaAdapter extends TypeAdapter<WatchPointer> {
  @override
  final int typeId = 16;

  @override
  WatchPointer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchPointer(
      name: fields[0] as String,
      file: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchPointer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExternalWatchMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
