import 'package:get/get.dart';
import 'package:space_news_aggregator/databases/objectbox.dart';
import 'package:space_news_aggregator/models/article_model.dart';

class FavoritesController extends GetxController {
  final ObjectBox _objectBox = Get.find();
  final RxSet<Article> _favorites = <Article>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  void _loadFavorites() async {
    _favorites.addAll(await _objectBox.getFavorites());
  }

  bool isFavorite(Article article) {
    return _favorites.contains(article);
  }

  void toggleFavorite(Article article) {
    if (isFavorite(article)) {
      _favorites.remove(article);
      _objectBox.removeFavorite(article);
    } else {
      _favorites.add(article);
      _objectBox.addFavorite(article);
    }
  }

  Set<Article> get favorites => _favorites;
}
