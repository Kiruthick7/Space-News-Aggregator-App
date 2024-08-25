import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_news_aggregator/controllers/article_controller.dart';
import 'package:space_news_aggregator/widgets/article_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticlesController articlesController =
        Get.find<ArticlesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Articles'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: Obx(() {
          if (articlesController.favoriteArticles.isEmpty) {
            return const Center(
              child: Text('No favorite articles yet.'),
            );
          } else {
            return ListView.builder(
              itemCount: articlesController.favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = articlesController.favoriteArticles[index];
                return ArticleCard(
                  imageUrl: article.imageUrl,
                  title: article.title,
                  summary: article.summary,
                  publishedAt: article.publishedAt,
                  isFavorited: true.obs,
                  article: article,
                );
              },
            );
          }
        }),
      ),
    );
  }
}
