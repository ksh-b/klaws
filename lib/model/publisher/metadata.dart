// Publisher from JSON files
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PublisherMetadata {
  String name = "";
  String homePage = "";
  List<String> category = [];
  Categories categories = Categories.empty();
  String categoryUrl = "";
  String iconUrl = "";
  bool supportsCustomCategory = false;
  SourceArticle categoryArticles = SourceArticle.empty();
  SourceArticle article = SourceArticle.empty();
  String searchUrl = "";
  SourceArticle searchArticles = SourceArticle.empty();
  Headers headers = Headers.fromJson({});
  List<String> ads = [];

  PublisherMetadata({
    required this.name,
    required this.homePage,
    required this.iconUrl,
    required this.category,
    required this.categories,
    required this.categoryUrl,
    required this.supportsCustomCategory,
    required this.categoryArticles,
    required this.searchUrl,
    required this.searchArticles,
    required this.article,
    required this.headers,
    required this.ads,
  });

  PublisherMetadata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    homePage = json['home-page'];
    iconUrl = json['icon-url'];
    category = json['category'].cast<String>();
    categories = Categories.fromJson(json['categories']);
    categoryUrl = json['category-url'];
    supportsCustomCategory = json['supports-custom-category'];
    categoryArticles = SourceArticle.fromJson(json['category-articles']);
    searchUrl = json['search-url'];
    searchArticles = SourceArticle.fromJson(json['search-articles']);
    article = SourceArticle.fromJson(json['article']);
    headers = Headers.fromJson(json['headers']);
    ads = json['ads'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['home-page'] = homePage;
    data['icon-url'] = iconUrl;
    data['category'] = category;
    data['categories'] = categories.toJson();
    data['category-url'] = categoryUrl;
    data['supports-custom-category'] = supportsCustomCategory;
    data['category-articles'] = categoryArticles.toJson();
    data['search-url'] = searchUrl;
    data['search-articles'] = searchArticles.toJson();
    data['article'] = article.toJson();
    data['headers'] = headers.toJson();
    data['ads'] = ads;
    return data;
  }

  @override
  String toString() => json.encode(toJson());
}


@JsonSerializable()
class Categories {
  String extractor = "";
  List<String> locator = [];
  Include include = Include.fromJson({});
  List<String> exclude = [];

  Categories({
    required this.extractor,
    required this.locator,
    required this.include,
    required this.exclude,
  });

  Categories.empty();

  Categories.fromJson(Map<String, dynamic> json) {
    extractor = json['extractor'];
    locator = json['locator'].cast<String>();
    include = Include.fromJson(json['include'].cast<String, String>());
    exclude = json['exclude'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extractor'] = extractor;
    data['locator'] = locator;
    data['include'] = include.toJson();
    data['exclude'] = exclude;
    return data;
  }
}


@JsonSerializable()
class SourceArticle {
  String extractor = "";
  Locators locators = Locators.empty();
  String timezone = "";
  String dateFormat = "";
  List<Map<String, dynamic>> modifications = [];

  SourceArticle({
    required this.extractor,
    required this.locators,
    required this.timezone,
    required this.dateFormat,
    required this.modifications,
  });

  SourceArticle.empty();

  SourceArticle.fromJson(Map<String, dynamic> json) {
    extractor = json['extractor'];
    locators = Locators.fromJson(json['locators']);
    timezone = json['timezone'];
    dateFormat = json['date-format'];
    modifications = json['modifications'].cast<Map<String, dynamic>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extractor'] = extractor;
    data['locators'] = locators;
    data['details'] = locators.toJson();
    data['timezone'] = timezone;
    data['date-format'] = dateFormat;
    modifications = data['modifications'];
    return data;
  }
}


@JsonSerializable()
class Locators {
  String container = "";
  String title = "";
  String excerpt = "";
  String author = "";
  String thumbnail = "";
  String url = "";
  String time = "";
  List<String> tags = [];
  String category = "";
  List<String> content = [];

  Locators({
    required this.container,
    required this.title,
    required this.content,
    required this.url,
    required this.excerpt,
    required this.author,
    required this.time,
    required this.category,
    required this.tags,
    required this.thumbnail,
  });

  Locators.empty();

  Locators.fromJson(Map<String, dynamic> json) {
    container = json['container'];
    title = json['title'];
    excerpt = json['excerpt'];
    author = json['author'];
    thumbnail = json['thumbnail'];
    url = json['url'];
    time = json['time'];
    tags = json['tags'].cast<String>();
    category = json['category'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['container'] = container;
    data['title'] = title;
    data['excerpt'] = excerpt;
    data['author'] = author;
    data['thumbnail'] = thumbnail;
    data['url'] = url;
    data['time'] = time;
    data['tags'] = tags;
    data['category'] = category;
    data['content'] = content;
    return data;
  }
}

@JsonSerializable()
class Headers {
  Map<String, dynamic> json_ = {};
  Headers({required this.json_});
  Headers.fromJson(Map<String, dynamic> json) {
    json_ = json;
  }

  Map<String, dynamic> toJson() {
    return json_;
  }
}

@JsonSerializable()
class Include {
  Map<String, String> json_ = {};
  Include({required this.json_});

  Include.fromJson(Map<String, String> json) {
    json_ = json;
  }

  Map<String, String> toJson() {
    return json_;
  }
}
