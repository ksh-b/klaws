import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:klaws/model/publisher/article.dart';
import 'package:klaws/model/publisher/metadata.dart';
part 'publisher.g.dart';

@JsonSerializable()
class Publisher {
  final String id;
  final String name;
  final String homePage;
  final bool hasSearchSupport;
  final bool hasCustomSupport;
  final String iconUrl;
  final List<String> siteCategories;
  final PublisherMetadata? metadata;
  List<Publisher> otherVersions = [];

  Publisher({
    required this.id,
    required this.name,
    required this.homePage,
    required this.hasSearchSupport,
    required this.hasCustomSupport,
    required this.iconUrl,
    required this.siteCategories,
    this.metadata,
  });

  Future<Article> article(Article article, Dio dio) {
    throw UnimplementedError();
  }

  Future<Set<Article>> articles({
    required String category,
    int page = 1,
    required Dio dio,
  }) {
    return category.startsWith("#")
        ? searchedArticles(
          searchQuery:
              category.startsWith("#")
                  ? category.replaceFirst("#", "")
                  : category,
          page: page,
          dio: dio,
        )
        : categoryArticles(category: category, page: page, dio: dio);
  }

  Future<Set<Article>> categoryArticles({
    required String category,
    int page = 1,
    required Dio dio,
  }) async {
    return <Article>{};
  }

  Future<Set<Article>> searchedArticles({
    required String searchQuery,
    int page = 1,
    required Dio dio,
  }) async {
    return <Article>{};
  }

  Future<Map<String, String>> categories(Dio dio) async {
    return {};
  }

  factory Publisher.fromJson(Map<String, dynamic> json) => _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);

  @override
  String toString() => json.encode(toJson());
}
