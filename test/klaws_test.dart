import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:klaws/klaws.dart';
import 'package:klaws/model/source/nest.dart';
import 'package:klaws/model/source/other_version.dart';
import 'package:klaws/model/source/sources_json.dart';
import 'package:klaws/provider/repo_provider.dart';
import 'package:klaws/repository/json.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      final directory = "/home/kshib/build/klaws/corax-main/";
      String extractedDir = "/home/kshib/build/klaws/corax-main/";
      var repo = await RepoProvider.getRepo("https://github.com/raven-repo/sources-world-news");
      final sourcesFile = File("${extractedDir}sources.json");
      Dio dio = Dio(BaseOptions(headers:
      {
        'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
      }));
      String sourcesJson = await sourcesFile.readAsString();
      var sources = ExternalSources.fromJson(json.decode(sourcesJson));
      repo!.name = sources.name;
      for (var source_ in sources.feeds) {
        if(source_.name!="Reuters") {
          continue;
        }
        final file = File("$extractedDir${source_.file}");
        String jsonString = await file.readAsString();
        Nest source =
        Nest.fromJson(json.decode(jsonString));
        JsonSource jsonSource = JsonSource(
          id: '${repo.id}/${source.name}',
          hasCustomSupport: source.supportsCustomCategory,
          nest: source,
          hasSearchSupport: source.searchUrl.isNotEmpty,
          homePage: source.homePage,
          iconUrl: source.iconUrl,
          name: source.name,
          siteCategories: source.category,
        );
        var categories = await jsonSource.categories(dio);
        var query = "";
        for (var category in categories.entries) {
          print("\n${source.name}/${category.value}\n");
          var categoryArticles = await FeedExtractor().extractCategoryArticles(
              jsonSource, category.value, dio);
          query=categoryArticles.first.title.split(" ").toList().where((word) => word.length>4).toList().first;
          print(json.encode(categoryArticles.map((e) => {
            "url": e.url,
            "title": e.title,
            "content": e.content,
            "excerpt": e.excerpt,
            "thumbnail": e.thumbnail,
            "tags": e.tags,
            "author": e.author,
          }).toList()));
        }

        print("\n${source.name}/Search\n");
        var searchArticles = await FeedExtractor().extractSearchArticles(jsonSource, query, dio);
        print(json.encode(searchArticles.map((e) => {
          "url": e.url,
          "title": e.title,
          "content": e.content,
          "excerpt": e.excerpt,
          "thumbnail": e.thumbnail,
          "tags": e.tags,
          "author": e.author,
        }).toList()));

        for (OtherVersion ov in source_.otherversions) {
          print("\n${ov.name}\n");
          final file = File(
            "$extractedDir/${ov.file}",
          );
          String jsonString = await file.readAsString();
          Nest source =
          Nest.fromJson(json.decode(jsonString));
          jsonSource.otherVersions.add(JsonSource(
            id: '${repo.id}/${ov.name}',
            hasCustomSupport: source.supportsCustomCategory,
            nest: source,
            hasSearchSupport: source.searchUrl.isNotEmpty,
            homePage: source.homePage,
            iconUrl: source.iconUrl,
            name: source.name,
            siteCategories: source.category,
          ));
        }
      }
    });
  });
}
