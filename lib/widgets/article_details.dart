import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_news_aggregator/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ArticleCardDetails extends StatelessWidget {
  final Article article;

  const ArticleCardDetails({super.key, required this.article});

  void _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Invalid URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? const Color(0xFF1B263B) : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              _buildHeaderImage(article.imageUrl),
              _buildTitle(article.title),
              _buildSummary(article.summary),
              _buildReadMoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? const Color(0xFF1B263B) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Get.isDarkMode
                ? const Color(0x1F000000)
                : const Color(0x33000000),
            offset: const Offset(0, 0),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'Article Details',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String imageUrl) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 28),
      decoration: BoxDecoration(
        color:
            Get.isDarkMode ? const Color(0x0DFFFFFF) : const Color(0x0D000000),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: 338,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[800],
              height: 338,
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              height: 338,
              color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSummary(String summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        summary,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Get.isDarkMode
              ? Colors.white.withOpacity(0.7)
              : Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: () {
          _launchURL(article.url);
        },
        child: Center(
          child: Text(
            'Read More',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
