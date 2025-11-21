// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) =>
    Article(
        publisher: Publisher.fromJson(
          json['publisher'] as Map<String, dynamic>,
        ),
        name: json['name'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        excerpt: json['excerpt'] as String,
        author: json['author'] as String,
        url: json['url'] as String,
        thumbnail: json['thumbnail'] as String,
        category: json['category'] as String,
        tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
        publishedAt: (json['publishedAt'] as num).toInt(),
        publishedAtString: json['publishedAtString'] as String,
      )
      ..id = (json['id'] as num).toInt()
      ..metadata = Map<String, String>.from(json['metadata'] as Map);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'publisher': instance.publisher,
  'name': instance.name,
  'title': instance.title,
  'content': instance.content,
  'excerpt': instance.excerpt,
  'author': instance.author,
  'url': instance.url,
  'thumbnail': instance.thumbnail,
  'category': instance.category,
  'tags': instance.tags,
  'publishedAt': instance.publishedAt,
  'publishedAtString': instance.publishedAtString,
  'metadata': instance.metadata,
};
