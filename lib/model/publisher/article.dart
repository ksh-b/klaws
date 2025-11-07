import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:klaws/model/publisher/publisher.dart';

part 'article.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  Publisher publisher;
  @HiveField(1)
  String name;
  @HiveField(2)
  String title;
  @HiveField(3)
  String content;
  @HiveField(4)
  String excerpt;
  @HiveField(5)
  String author;
  @HiveField(6)
  String url;
  @HiveField(7)
  String thumbnail;
  @HiveField(8)
  String category;
  @HiveField(9)
  List<String> tags;
  @HiveField(10)
  int publishedAt;
  @HiveField(12)
  String publishedAtString;
  @HiveField(11)
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
