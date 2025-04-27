import 'package:dio/dio.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/source/nest.dart';
import 'package:klaws/provider/extractor/css.dart';
import 'package:klaws/provider/extractor/json.dart';
import 'package:klaws/repository/json.dart';

import 'extractor/readability.dart';

class FeedExtractor {

  Future<Set<Article>> extractSearchArticles(
    JsonSource source,
    String query,
      Dio dio
  ) async {
    List<Article> articleList = [];
    SourceArticle? searchArticles = source.nest?.searchArticles;
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
    if (source.nest?.article.extractor == "css") {
      article = (await extractArticleCss(source, article, dio));
    } else if (source.nest?.article.extractor == "json") {
      article = (await extractArticleJson(source, article, dio));
    } else if (source.nest?.article.extractor == "readability") {
      article = (await extractArticle(source, article, dio));
    }
    return article;
  }

  Future<Map<String, String>> extractCategories(JsonSource source, Dio dio) async {
    Map<String, String> categories = {};
    var extractor = source.nest?.categories.extractor;
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
    if (source.nest?.categoryArticles.extractor == "css") {
      articleList = await extractCategoryArticlesCss(
        source,
        category,
        1, dio
      );
    } else if (source.nest?.categoryArticles.extractor == "json") {
      articleList = await extractCategoryArticlesJson(
        source,
        category,
        1, dio
      );
    }
    return articleList.toSet();
  }
}
