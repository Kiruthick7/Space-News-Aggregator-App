import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:space_news_aggregator/databases/objectbox.g.dart';
import 'package:space_news_aggregator/models/article_model.dart';

class ObjectBox {
  static ObjectBox? _instance;
  late final Store _store;
  late final Box<Article> _articleBox;

  ObjectBox._(this._store) {
    _articleBox = _store.box<Article>();
  }

  static Future<ObjectBox> create() async {
    if (_instance != null) {
      return _instance!;
    }

    final hasPermission = await Permission.storage.request().isGranted;
    if (!hasPermission) {
      throw Exception('Storage permission not granted');
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final objectBoxDirectory = Directory('${directory.path}/objectbox');
      if (!await objectBoxDirectory.exists()) {
        await objectBoxDirectory.create(recursive: true);
      }

      final store = await openStore(directory: objectBoxDirectory.path);
      _instance = ObjectBox._(store);
      return _instance!;
    } catch (e) {
      throw Exception('Failed to initialize ObjectBox: $e');
    }
  }

  Box<Article> get articleBox => _articleBox;

  Future<void> addFavorite(Article article) async {
    _articleBox.put(article);
  }

  Future<void> removeFavorite(Article article) async {
    if (article.id > 0) {
      _articleBox.remove(article.id);
    } else {
      throw Exception('Invalid article ID for removal');
    }
  }

  Future<Set<Article>> getFavorites() async {
    final articles = _articleBox.getAll();
    return articles.toSet();
  }
}
