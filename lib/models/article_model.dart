import 'package:objectbox/objectbox.dart';
import 'package:space_news_aggregator/databases/objectbox_model.dart';

@Entity()
class Article {
  @Id(assignable: true)
  int id;

  final String title;
  final String summary;
  final String publishedAt;
  final String newsSite;
  final String source;
  final String url;
  final String imageUrl;

  Article({
    this.id = 0,
    required this.title,
    required this.summary,
    required this.publishedAt,
    required this.newsSite,
    required this.source,
    required this.url,
    required this.imageUrl,
  });

  // Convert Favorite back to Article
  factory Article.fromFavorite(Favorite favorite) {
    return Article(
      id: favorite.id,
      title: favorite.title,
      summary: favorite.summary,
      publishedAt: favorite.publishedDate,
      source: favorite.source,
      url: favorite.url,
      imageUrl: favorite.imageUrl,
      newsSite: '',
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      publishedAt: json['published_at'] ?? '',
      newsSite: json['news_site'] ?? 'Unknown',
      source: json['url'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
