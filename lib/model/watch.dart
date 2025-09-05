
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:klaws/model/source/watch_dart.dart';

part 'watch.g.dart';

@JsonSerializable()
@HiveType(typeId: 17)
class WatchProducer {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Watch watch;

  WatchProducer({
    required this.id,
    required this.watch,
  });

  factory WatchProducer.fromJson(Map<String, dynamic> json) => _$WatchFromJson(json);

  Map<String, dynamic> toJson() => _$WatchToJson(this);

}
