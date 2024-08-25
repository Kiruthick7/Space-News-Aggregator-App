import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:space_news_aggregator/models/article_model.dart';

class NewsService {
  static Future<List<Article>> fetchArticles(
      {int limit = 10, offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.spaceflightnewsapi.net/v4/articles/?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['results'] != null && data['results'] is List) {
          List<dynamic> articlesJson = data['results'];
          return articlesJson.map((json) => Article.fromJson(json)).toList();
        } else {
          throw Exception(
              'Unexpected JSON structure: results field is missing or not a list');
        }
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      print('Error fetching articles: $e');
      return [];
    }
  }
}
