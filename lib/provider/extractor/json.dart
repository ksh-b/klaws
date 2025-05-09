import 'package:dio/dio.dart';
import 'package:json_path/json_path.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/publisher.dart';
import 'package:klaws/model/source/nest.dart';
import 'package:klaws/model/source/util.dart';

Future<Map<String, String>> extractCategoriesJson(Source source) async {
  Include? locatorsInclude = source.nest!.categories.include;
  return locatorsInclude.json_;
}

Future<List<Article>> extractCategoryArticlesJson(
  Source source,
  String category,
  int page,
    Dio dio
) async {
  String? url = source.nest!.categoryUrl
      .replaceAll("{home-page}", source.nest!.homePage)
      .replaceAll("{category}", category.replaceAll("/", ""))
      .replaceAll("{size}", "10")
      .replaceAll("{offset}", "${(page - 1) * 10}")
      .replaceAll("{page}", "$page");

  return await extractArticlesJson(
    url,
    source,
    category,
    source.nest!.categoryArticles, dio
  );
}

Future<List<Article>> extractSearchArticlesJson(
  Source source,
  String query,
  int page,
    Dio dio
) async {
  String? url = source.nest!.searchUrl
      .replaceAll("{home-page}", source.nest!.homePage)
      .replaceAll("{query}", query)
      .replaceAll("{size}", "10")
      .replaceAll("{offset}", "${(page - 1) * 10}")
      .replaceAll("{page}", "$page");

  return await extractArticlesJson(
    url,
    source,
    query,
    source.nest!.searchArticles, dio
  );
}

Future<Article> extractArticleJson(
  Source source,
  Article article,
    Dio dio
) async {
  var slug = article.url;
  var url = slug;
  if (!slug.contains(source.nest!.homePage)) {
    url = source.nest!.article.locators.url.replaceAll("{url}", slug);
  }
  final response = await dio.get(url, queryParameters: source.nest!.headers.json_);

  var locator = source.nest!.article.locators;
  var titleNode = locator.title.isEmpty ? null : JsonPath(locator.title);
  var authorNode = locator.author.isEmpty ? null : JsonPath(locator.author);
  var thumbnailNode =
      locator.thumbnail.isEmpty ? null : JsonPath(locator.thumbnail);
  var contentNode =
      locator.content.isEmpty ? null : JsonPath(locator.content.first);
  var timeNode = locator.time.isEmpty ? null : JsonPath(locator.time);
  var tagsNode = locator.tags.isEmpty ? null : JsonPath(locator.tags.first);
  var excerptNode = locator.excerpt.isEmpty ? null : JsonPath(locator.excerpt);
  // var urlNode = locator.url.isEmpty? null : JsonPath(locator.url);
  var categoryNode =
      locator.category.isEmpty ? null : JsonPath(locator.category);

  var json = response.data;
  var title = titleNode?.asList(json).firstOrNull ?? article.title;
  var author = authorNode?.asList(json).firstOrNull ?? article.author;
  var thumbnail =
      thumbnailNode?.asList(json).firstOrNull ?? article.thumbnail;
  var content = contentNode?.asList(json).firstOrNull ?? article.content;
  var timeStr = timeNode?.asList(json).firstOrNull ?? article.publishedAtString;
  var tags = tagsNode?.asList(json) ?? article.tags;
  var excerpt = excerptNode?.asList(json).firstOrNull ?? article.excerpt;
  // var url_ = urlNode?.asList(json).firstOrNull ?? article['url'];
  var category = categoryNode?.asList(json).firstOrNull ?? article.category;

  var epoch = article.publishedAt;
  if (epoch == -1) {
    epoch = getEpochTimeFromString(
      source.nest!.searchArticles.dateFormat,
      timeStr,
    );
  }

  url = source.nest!.article.locators.url
      .replaceAll("{category}", category)
      .replaceAll("{url}", slug);

  if(!url.startsWith("http")) {
    if (url.startsWith("/")) {
      url = source.homePage + url;
    } else {
      url = "${source.homePage}/$url";
    }
  }

  return Article(
    source: source,
    sourceName: source.name,
    title: title,
    author: author,
    thumbnail: thumbnail,
    url: url,
    publishedAt: epoch,
    publishedAtString: timeStr,
    category: category,
    content: content.trim(),
    excerpt: excerpt,
    tags: tags.cast<String>(),
  );
}

Future<List<Article>> extractArticlesJson(
  String url,
  Source source,
  String category,
  SourceArticle type,
    Dio dio
) async {
  Response<dynamic> response = await getResponse(source.nest!, url, dio);
  var json = response.data;
  List<Article> articleList = [];

  var locator = type.locators;
  var articles = JsonPath(locator.container);
  var size = articles.read(json).length;
  var container = locator.container.replaceFirst(".*", "[i].");
  for (var i = 0; i < size; i++) {
    var titleNode = locator.title.isNotEmpty
        ? JsonPath((container + locator.title).replaceAll("[i]", "[$i]"))
        : null;
    var authorNode = locator.author.isNotEmpty
        ? JsonPath((container + locator.author).replaceAll("[i]", "[$i]"))
        : null;
    var thumbnailNode = locator.thumbnail.isNotEmpty
        ? JsonPath((container + locator.thumbnail).replaceAll("[i]", "[$i]"))
        : null;
    var contentNode = locator.content.isNotEmpty
        ? JsonPath(
            (container + locator.content.first).replaceAll("[i]", "[$i]"))
        : null;
    var timeNode = locator.time.isNotEmpty
        ? JsonPath((container + locator.time).replaceAll("[i]", "[$i]"))
        : null;
    var tagsNode = locator.tags.isNotEmpty
        ? JsonPath((container + locator.tags.first).replaceAll("[i]", "[$i]"))
        : null;
    var excerptNode = locator.excerpt.isNotEmpty
        ? JsonPath((container + locator.excerpt).replaceAll("[i]", "[$i]"))
        : null;
    var urlNode = locator.url.isNotEmpty
        ? JsonPath((container + locator.url).replaceAll("[i]", "[$i]"))
        : null;

    var title = titleNode?.asList(json).firstOrNull ?? "";
    var author = authorNode?.asList(json).firstOrNull ?? "";
    var thumbnail = thumbnailNode?.asList(json).firstOrNull ?? "";
    var content = contentNode?.asList(json).firstOrNull ?? "";
    var time = timeNode?.asList(json).firstOrNull ?? "";
    var tags = tagsNode?.asList(json) ?? [];
    var excerpt = excerptNode?.asList(json).firstOrNull ?? "";
    var url_ = urlNode?.asList(json).firstOrNull ?? "";

    var epoch = getEpochTimeFromString(
      type.dateFormat,
      time,
    );

    if(!url_.startsWith("http")) {
      if (url_.startsWith("/")) {
        url_ = source.homePage + url_;
      } else {
        url_ = "${source.homePage}/$url_";
      }
    }


    articleList.add(Article(
      source: source,
      sourceName: source.name,
      title: title,
      author: author,
      thumbnail: thumbnail,
      url: url_,
      publishedAt: epoch,
      publishedAtString: time,
      category: category,
      content: content.trim(),
      excerpt: excerpt,
      tags: tags.cast<String>(),
    ));
  }

  return articleList;
}
