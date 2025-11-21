
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'publisher.dart';
part 'article.g.dart';

@JsonSerializable()
class Article {
  int id = 0;
  Publisher publisher;
  String name;
  String title;
  String content;
  String excerpt;
  String author;
  String url;
  String thumbnail;
  String category;
  List<String> tags;
  int publishedAt;
  String publishedAtString;
  Map<String, String> metadata = {};

  Article({
    required this.publisher,
    required this.name,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.url,
    required this.thumbnail,
    required this.category,
    required this.tags,
    required this.publishedAt,
    required this.publishedAtString,

  });

  Article fill({
    String? title,
    String? content,
    String? excerpt,
    String? author,
    String? url,
    String? thumbnail,
    List<String>? tags,
    int? publishedAt,
    String? publishedAtString,
    String? category,
  }) {
    return Article(
      publisher: publisher,
      name: name,
      title: title ?? this.title,
      content: content ?? this.content,
      excerpt: excerpt ?? this.excerpt,
      author: author ?? this.author,
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
      publishedAt: publishedAt ?? this.publishedAt,
      publishedAtString: publishedAtString ?? this.publishedAtString,
      category: category ?? this.category,
      tags: this.tags,
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() => json.encode(toJson());

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Article &&
            runtimeType == other.runtimeType &&
            title == other.title &&
            publisher.id == other.publisher.id;
  }

  @override
  int get hashCode => title.hashCode ^ publisher.id.hashCode;

}
