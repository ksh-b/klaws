import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:json_path/json_path.dart';
import 'package:klaws/model/trend/trends.dart';
import 'package:klaws/util/util.dart';

class TrendExtractor {
  Future<List<String>> extractTrends(
      Trends trend,
      Dio dio
  ) async {
    List<String> trends = [];
    final response = await dio.get(trend.url);
    if (trend.extractor == "css") {
      var document = html.parse(response.data);
      List<Element> elements = document.querySelectorAll(trend.locator);
      trends = elements.map((e) => e.text).toList();
    } else if (trend.extractor == "json") {
      trends = JsonPath(trend.locator).asList(response.data).toList();
    }
    return trends;
  }
}