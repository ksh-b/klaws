import 'package:dio/dio.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/source/source_dart.dart';
import 'package:klaws/model/source/sources_json.dart';
import 'package:klaws/provider/extractor/css.dart';
import 'package:klaws/provider/extractor/json.dart';
import 'package:klaws/repository/git/github.dart';
import 'package:klaws/repository/json.dart';

class FeedExtractor {

  Future<Set<Article>> extractSearchArticles(
    JsonSource source,
    String query,
      Dio dio
  ) async {
    List<Article> articleList = [];
    SourceArticle? searchArticles = source.externalSource?.searchArticles;
    if (searchArticles?.extractor == "css") {
      articleList = await extractSearchArticlesCss(source, query, 1, dio);
    } else if (searchArticles?.extractor == "json") {
      articleList = await extractSearchArticlesJson(source, query, 1, dio);
    }
    return articleList.toSet();
  }

  Future<Article> extractArticleContent(
    JsonSource source,
    Article article,
      Dio dio
  ) async {
    if (source.externalSource?.article.extractor == "css") {
      article = (await extractArticleCss(source, article, dio));
    } else if (source.externalSource?.article.extractor == "json") {
      article = (await extractArticleJson(source, article, dio));
    }
    return article;
  }

  Future<Map<String, String>> extractCategories(JsonSource source, Dio dio) async {
    Map<String, String> categories = {};
    var extractor = source.externalSource?.categories.extractor;
    if (extractor == "css") {
      categories = await extractCategoriesCss(source, dio);
    } else if (extractor == "json") {
      categories = await extractCategoriesJson(source);
    }
    return categories;
  }

  Future<Set<Article>> extractCategoryArticles(
    JsonSource source,
    String category,
      Dio dio
  ) async {
    List<Article> articleList = [];
    if (source.externalSource?.categoryArticles.extractor == "css") {
      articleList = await extractCategoryArticlesCss(
        source,
        category,
        1, dio
      );
    } else if (source.externalSource?.categoryArticles.extractor == "json") {
      articleList = await extractCategoryArticlesJson(
        source,
        category,
        1, dio
      );
    }
    return articleList.toSet();
  }
}
