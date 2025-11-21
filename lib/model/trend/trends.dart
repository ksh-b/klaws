import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'trends.g.dart';

@JsonSerializable()
class Trends {
  String name;
  String url;
  String extractor;
  String favicon;
  String locator;

  Trends({
    required this.extractor,
    required this.locator,
    required this.name,
    required this.favicon,
    required this.url,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Trends &&
            runtimeType == other.runtimeType &&
            extractor == other.extractor &&
            locator == other.locator;
  }

  @override
  int get hashCode => extractor.hashCode ^ locator.hashCode;

  factory Trends.fromJson(Map<String, dynamic> json) => _$TrendsFromJson(json);

  Map<String, dynamic> toJson() => _$TrendsToJson(this);

  @override
  String toString() => json.encode(toJson());
}