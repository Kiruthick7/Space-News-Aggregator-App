import 'package:objectbox/objectbox.dart';
import 'package:space_news_aggregator/models/article_model.dart';

@Entity()
class Favorite {
  int id;
  String title;
  String summary;
  String publishedDate;
  String source;
  String url;
  String imageUrl;

  Favorite({
    this.id = 0,
    required this.title,
    required this.summary,
    required this.publishedDate,
    required this.source,
    required this.url,
    required this.imageUrl,
  });

  // Convert Article to Favorite
  factory Favorite.fromArticle(Article article) {
    return Favorite(
      title: article.title,
      summary: article.summary,
      publishedDate: article.publishedAt,
      source: article.url,
      url: article.url,
      imageUrl: article.imageUrl,
    );
  }
}
