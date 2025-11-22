// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublisherMetadata _$PublisherMetadataFromJson(Map<String, dynamic> json) =>
    PublisherMetadata(
      name: json['name'] as String,
      homePage: json['homePage'] as String,
      iconUrl: json['iconUrl'] as String,
      category: (json['category'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      categories: Categories.fromJson(
        json['categories'] as Map<String, dynamic>,
      ),
      categoryUrl: json['categoryUrl'] as String,
      supportsCustomCategory: json['supportsCustomCategory'] as bool,
      categoryArticles: SourceArticle.fromJson(
        json['categoryArticles'] as Map<String, dynamic>,
      ),
      searchUrl: json['searchUrl'] as String,
      searchArticles: SourceArticle.fromJson(
        json['searchArticles'] as Map<String, dynamic>,
      ),
      article: SourceArticle.fromJson(json['article'] as Map<String, dynamic>),
      headers: Headers.fromJson(json['headers'] as Map<String, dynamic>),
      ads: (json['ads'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PublisherMetadataToJson(PublisherMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'homePage': instance.homePage,
      'category': instance.category,
      'categories': instance.categories,
      'categoryUrl': instance.categoryUrl,
      'iconUrl': instance.iconUrl,
      'supportsCustomCategory': instance.supportsCustomCategory,
      'categoryArticles': instance.categoryArticles,
      'article': instance.article,
      'searchUrl': instance.searchUrl,
      'searchArticles': instance.searchArticles,
      'headers': instance.headers,
      'ads': instance.ads,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
  extractor: json['extractor'] as String,
  locator: (json['locator'] as List<dynamic>).map((e) => e as String).toList(),
  include: Include.fromJson(Map<String, String>.from(json['include'] as Map)),
  exclude: (json['exclude'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'extractor': instance.extractor,
      'locator': instance.locator,
      'include': instance.include,
      'exclude': instance.exclude,
    };

SourceArticle _$SourceArticleFromJson(Map<String, dynamic> json) =>
    SourceArticle(
      extractor: json['extractor'] as String,
      locators: Locators.fromJson(json['locators'] as Map<String, dynamic>),
      timezone: json['timezone'] as String,
      dateFormat: json['dateFormat'] as String,
      modifications: (json['modifications'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$SourceArticleToJson(SourceArticle instance) =>
    <String, dynamic>{
      'extractor': instance.extractor,
      'locators': instance.locators,
      'timezone': instance.timezone,
      'dateFormat': instance.dateFormat,
      'modifications': instance.modifications,
    };

Locators _$LocatorsFromJson(Map<String, dynamic> json) => Locators(
  container: json['container'] as String,
  title: json['title'] as String,
  content: (json['content'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
  excerpt: json['excerpt'] as String,
  author: json['author'] as String,
  time: json['time'] as String,
  category: json['category'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  thumbnail: json['thumbnail'] as String,
);

Map<String, dynamic> _$LocatorsToJson(Locators instance) => <String, dynamic>{
  'container': instance.container,
  'title': instance.title,
  'excerpt': instance.excerpt,
  'author': instance.author,
  'thumbnail': instance.thumbnail,
  'url': instance.url,
  'time': instance.time,
  'tags': instance.tags,
  'category': instance.category,
  'content': instance.content,
};

Headers _$HeadersFromJson(Map<String, dynamic> json) =>
    Headers(json_: json['json_'] as Map<String, dynamic>);

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{
  'json_': instance.json_,
};

Include _$IncludeFromJson(Map<String, dynamic> json) =>
    Include(json_: Map<String, String>.from(json['json_'] as Map));

Map<String, dynamic> _$IncludeToJson(Include instance) => <String, dynamic>{
  'json_': instance.json_,
};
