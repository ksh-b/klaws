import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:klaws/model/publisher/article.dart';
import 'package:klaws/model/publisher/metadata.dart';

part 'publisher.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Publisher {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String homePage;
  @HiveField(3)
  final bool hasSearchSupport;
  @HiveField(4)
  final bool hasCustomSupport;
  @HiveField(5)
  final String iconUrl;
  @HiveField(6)
  final List<String> siteCategories;
  @HiveField(7)
  final PublisherMetadata? metadata;
  @HiveField(8)
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

  factory Publisher.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
