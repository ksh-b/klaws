import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/publisher.dart';
import 'package:klaws/model/source/nest.dart';
import 'package:klaws/provider/feed_extractor.dart';

part 'json.g.dart';

@HiveType(typeId: 14)
class JsonSource extends Source {
  Dio dio = Dio();

  JsonSource({
    required super.id,
    required super.name,
    required super.homePage,
    required super.hasSearchSupport,
    required super.hasCustomSupport,
    required super.iconUrl,
    required super.siteCategories,
    required super.nest,
  });

  @override
  Future<Set<Article>> categoryArticles({
    String category = "",
    int page = 1,
  }) async {
    return FeedExtractor().extractCategoryArticles(this, category, dio);
  }

  @override
  Future<Set<Article>> searchedArticles({
    required String searchQuery,
    int page = 1,
  }) async {
    return FeedExtractor().extractSearchArticles(this, searchQuery, dio);
  }

  @override
  Future<Article> article(Article article) async {
    return FeedExtractor().extractArticleContent(this, article, dio);
  }

  @override
  Future<Map<String, String>> categories() async {
    return FeedExtractor().extractCategories(this, dio);
  }

}
