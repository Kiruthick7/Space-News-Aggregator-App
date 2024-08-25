import 'package:get/get.dart';
import 'package:space_news_aggregator/api/news_service.dart';
import 'package:space_news_aggregator/models/article_model.dart';

class ArticlesController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var favoriteArticles = <Article>[].obs;
  var filteredArticles = <Article>[].obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles({int limit = 10, int offset = 0}) async {
    try {
      isLoading(true);
      var fetchedArticles =
          await NewsService.fetchArticles(limit: limit, offset: offset);
      articles.addAll(fetchedArticles);
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      isLoading(false);
    }
  }

  // Check if an article is in the favorites list
  bool isFavorite(Article article) {
    return favoriteArticles.contains(article);
  }

  // Toggle the favorite status of an article
  void toggleFavorite(Article article) {
    if (isFavorite(article)) {
      favoriteArticles.remove(article);
    } else {
      favoriteArticles.add(article);
    }
  }

  // Filter articles based on a search query
  void filterArticles(String query) {
    if (query.isEmpty) {
      filteredArticles.value = articles;
    } else {
      filteredArticles.value = articles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
