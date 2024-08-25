import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:space_news_aggregator/controllers/article_controller.dart';
import 'package:space_news_aggregator/models/article_model.dart';
import 'package:space_news_aggregator/widgets/article_details.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String summary;
  final String publishedAt;
  final RxBool isFavorited;
  final Article article;

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.publishedAt,
    required this.isFavorited,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleCardDetails(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x1A000000)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(),
                const SizedBox(height: 12),
                _buildTextSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
              )
            : const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 48,
                ),
              ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white : const Color(0x80000000),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            summary,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Get.isDarkMode ? Colors.white60 : const Color(0x80000000),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatPublishedDate(publishedAt),
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color:
                      Get.isDarkMode ? Colors.white70 : const Color(0x80000000),
                ),
              ),
              Obx(() {
                return IconButton(
                  icon: Icon(
                    isFavorited.value ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited.value ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    isFavorited.value = !isFavorited.value;
                    final ArticlesController articlesController =
                        Get.find<ArticlesController>();
                    articlesController.toggleFavorite(article);
                  },
                );
              }),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  String _formatPublishedDate(String dateStr) {
    try {
      final DateTime dateTime = DateTime.parse(dateStr);
      final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
      final DateFormat timeFormatter = DateFormat('hh:mm:ss a');
      final String dateFormatted = dateFormatter.format(dateTime);
      final String timeFormatted = timeFormatter.format(dateTime);
      return 'Published At: $dateFormatted $timeFormatted';
    } catch (e) {
      return 'Invalid date';
    }
  }
}
