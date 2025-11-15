import 'dart:convert';
import 'dart:io';
import 'package:klaws/klaws.dart';
import 'package:klaws/model/pointers/pointers.dart';
import 'package:klaws/model/repo.dart';
import 'package:klaws/model/watch/watch.dart';
import 'package:klaws/repository/zip.dart';
import 'package:klaws/util/util.dart';

import 'package:dio/dio.dart';
import 'package:klaws/model/publisher/publisher.dart';
import 'package:klaws/model/publisher/metadata.dart';
import 'package:test/test.dart';

void main() {
  String repoUrl = "https://raw.githubusercontent.com/raven-repo/sources-news-technology/refs/heads/main/metadata.json";
  String folder = "sources-news-technology-main";

  test('download zip', () async {
    var zipSource = ZipSource(repoUrl);
    var repoMetadata = await zipSource.setup(path: "./test");
    print(repoMetadata.description);
  });

  test('load sources.json', () async {
    final pointersFile = File("./test/$folder/sources.json");
    String sourcesJson = await pointersFile.readAsString();
    var pointers = Pointers.fromJson(json.decode(sourcesJson));
    expect(pointers.name, isNotEmpty);
    expect(pointers.watchPointers.length + pointers.publisherPointers.length, isNonZero);
  });

  test('load source categories', () async {
    final file = File("./test/$folder/publishers/tech/tech_crunch.json");
    String jsonString = await file.readAsString();
    PublisherMetadata publisherMetadata = PublisherMetadata.fromJson(json.decode(jsonString));
    Publisher publisher = Publisher(
      id: 'test/$folder/${publisherMetadata.name}',
      hasCustomSupport: publisherMetadata.supportsCustomCategory,
      metadata: publisherMetadata,
      hasSearchSupport: publisherMetadata.searchUrl.isNotEmpty,
      homePage: publisherMetadata.homePage,
      iconUrl: publisherMetadata.iconUrl,
      name: publisherMetadata.name,
      siteCategories: publisherMetadata.category,
    );
    var categories = await FeedExtractor().extractCategories(publisher, Dio());
    print(categories);
    // todo: add category inclusion/exclusion checks
    if(!publisherMetadata.supportsCustomCategory) {
      expect(categories, isNotEmpty);
    }
  });

  test('load source category articles - page 1', () async {
    final file = File("./test/sources-news-technology-main/publishers/tech/tech_crunch.json");
    String jsonString = await file.readAsString();
    PublisherMetadata nest = PublisherMetadata.fromJson(json.decode(jsonString));
    Publisher source = Publisher(
      id: 'test/${nest.name}',
      hasCustomSupport: nest.supportsCustomCategory,
      metadata: nest,
      hasSearchSupport: nest.searchUrl.isNotEmpty,
      homePage: nest.homePage,
      iconUrl: nest.iconUrl,
      name: nest.name,
      siteCategories: nest.category,
    );
    var categories = await FeedExtractor().extractCategories(source, Dio());
    var catArticles = await FeedExtractor().extractCategoryArticles(
        source, categories.values.first, Dio()
    );
    expect(catArticles, isNotEmpty);

  });

  test('x load source category article', () async {
    final file = File("./test/sources-news-technology-main/publishers/tech/tech_crunch.json");
    String jsonString = await file.readAsString();
    PublisherMetadata nest = PublisherMetadata.fromJson(json.decode(jsonString));
    Publisher source = Publisher(
      id: 'test/${nest.name}',
      hasCustomSupport: nest.supportsCustomCategory,
      metadata: nest,
      hasSearchSupport: nest.searchUrl.isNotEmpty,
      homePage: nest.homePage,
      iconUrl: nest.iconUrl,
      name: nest.name,
      siteCategories: nest.category,
    );
    var categories = await FeedExtractor().extractCategories(source, Dio());
    var catArticles = await FeedExtractor().extractCategoryArticles(
        source, categories.values.first, Dio()
    );
    expect(catArticles, isNotEmpty);
    var article = catArticles.first;
    article = await FeedExtractor().extractArticleContent(source, article, Dio());
    print(article.title);
    print(article.content);

    expect(article.title, isNotEmpty);
    expect(article.content, isNotEmpty);

  });


  test('load watch', () async {
    final file = File("./test/sources-news-technology-main/watches/stock-market/nasdaq.json");
    String jsonString = await file.readAsString();
    Watch watch = Watch.fromJson(json.decode(jsonString));
    var w = await WatchExtractor().extractWatchContent(
        watch, "https://finance.yahoo.com/quote/AAPL/", Dio()
    );
    print(w?.title);

  });

}
