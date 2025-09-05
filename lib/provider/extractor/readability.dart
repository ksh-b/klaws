import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/publisher.dart';
import 'package:xayn_readability_core/xayn_readability_core.dart' as readability;

Future<Article> extractArticle(
  Publisher source,
  Article article,
  Dio dio,
) async {
  if(source.metadata!=null && source.metadata!.headers.json_.isNotEmpty) {
    dio.options = BaseOptions(headers: source.metadata!.headers.json_);
  }
  var response = await dio.get(article.url);
  var html = parse(response);
  var fullArticle = readability.parse(html);
  return Article(
    publisher: article.publisher,
    name: article.name,
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
