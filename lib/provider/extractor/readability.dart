import 'package:dio/dio.dart';
import 'package:klaws/model/article.dart';
import 'package:klaws/model/publisher.dart';
import 'package:readability/readability.dart' as readability;

Future<Article> extractArticle(
  Source source,
  Article article,
  Dio dio,
) async {
  if(source.nest!=null && source.nest!.headers.json_.isNotEmpty) {
    dio.options = BaseOptions(headers: source.nest!.headers.json_);
  }
  var fullArticle = await readability.parseAsync(article.url);
  return Article(
    source: article.source,
    sourceName: article.sourceName,
    title: fullArticle.title ?? article.title,
    content: fullArticle.content ?? article.content,
    excerpt: fullArticle.excerpt ?? article.excerpt,
    author: fullArticle.author ?? article.author,
    url: article.url,
    thumbnail: fullArticle.imageUrl ?? article.thumbnail,
    category: article.category,
    tags: article.tags,
    publishedAt: article.publishedAt,
    publishedAtString: fullArticle.publishedTime ?? article.publishedAtString,
  );
}
