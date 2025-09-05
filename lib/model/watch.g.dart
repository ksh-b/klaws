// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchAdapter extends TypeAdapter<WatchProducer> {
  @override
  final int typeId = 17;

  @override
  WatchProducer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchProducer(
      id: fields[0] as String,
      watch: fields[1] as Watch,
    );
  }

  @override
  void write(BinaryWriter writer, WatchProducer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.watch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProducer _$WatchFromJson(Map<String, dynamic> json) => WatchProducer(
      id: json['id'] as String,
      watch: Watch.fromJson(json['watch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WatchToJson(WatchProducer instance) => <String, dynamic>{
      'id': instance.id,
      'watch': instance.watch,
    };
