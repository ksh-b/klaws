import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/publisher.dart';
import 'package:xayn_readability_core/xayn_readability_core.dart' as readability;

Future<Article> extractArticle(
  Source source,
  Article article,
  Dio dio,
) async {
  if(source.nest!=null && source.nest!.headers.json_.isNotEmpty) {
    dio.options = BaseOptions(headers: source.nest!.headers.json_);
  }
  var response = await dio.get(article.url);
  var html = parse(response);
  var fullArticle = readability.parse(html);
  return Article(
    source: article.source,
    sourceName: article.sourceName,
    title: fullArticle?.metadata.title ?? article.title,
    content: fullArticle?.html ?? html.body?.innerHtml ?? article.content,
    excerpt: fullArticle?.metadata.excerpt ?? article.excerpt,
    author: fullArticle?.metadata.byline ?? article.author,
    url: article.url,
    thumbnail: article.thumbnail,
    category: article.category,
    tags: article.tags,
    publishedAt: article.publishedAt,
    publishedAtString: article.publishedAtString,
  );
}
