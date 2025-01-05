import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:klaws/klaws.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/source/source_dart.dart';
import 'package:klaws/repository/json.dart';

void main() async {
  var extractor = FeedExtractor();
  Dio dio = Dio();
  final response = await dio.get(
    'https://raw.githubusercontent.com/ksh-b/corax/refs/heads/main/feeds/news/technology/android_police.json',
  );
  ExternalSource externalSource = ExternalSource.fromJson(jsonDecode(response.data));
  JsonSource jsonSource = JsonSource(
    id: "test",
    name: externalSource.name,
    homePage: externalSource.homePage,
    hasSearchSupport: externalSource.searchUrl.isNotEmpty,
    hasCustomSupport: externalSource.supportsCustomCategory,
    iconUrl: externalSource.iconUrl,
    siteCategories: externalSource.category,
    externalSource: externalSource,
  );
  Map<String, String> categories = await extractor.extractCategories(jsonSource, dio);
  print(categories);

  var category = categories.entries.first;
  Set<Article> articles = await extractor.extractCategoryArticles(jsonSource, category.value, dio);
  var article = articles.first;
  print(article.toJson());

  article = await extractor.extractArticleContent(jsonSource, article, dio);
  print(article.toJson());


}
