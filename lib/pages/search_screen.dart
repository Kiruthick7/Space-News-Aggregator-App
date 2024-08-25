import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_news_aggregator/controllers/article_controller.dart';
import 'package:space_news_aggregator/widgets/article_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ArticlesController _articlesController = Get.find<ArticlesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Articles'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                filled: true,
                fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              onChanged: (query) {
                _articlesController.filterArticles(query);
              },
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Obx(() {
            if (_articlesController.filteredArticles.isEmpty &&
                _searchController.text.isNotEmpty) {
              return const Center(
                child: Text('No articles found.'),
              );
            } else if (_searchController.text.isEmpty) {
              return const Center(
                child: Text('Start typing to search for articles.'),
              );
            } else {
              return ListView.builder(
                itemCount: _articlesController.filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = _articlesController.filteredArticles[index];
                  return ArticleCard(
                    imageUrl: article.imageUrl,
                    title: article.title,
                    summary: article.summary,
                    publishedAt: article.publishedAt,
                    isFavorited: _articlesController.isFavorite(article).obs,
                    article: article,
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
