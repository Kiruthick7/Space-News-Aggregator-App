import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_news_aggregator/controllers/article_controller.dart';
import 'package:space_news_aggregator/pages/favorites_screen.dart';
import 'package:space_news_aggregator/pages/search_screen.dart';
import 'package:space_news_aggregator/widgets/article_card.dart';
import 'package:space_news_aggregator/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final ArticlesController articlesController = Get.put(ArticlesController());

  final List<Widget> _pages = [
    const HomeContentPage(),
    const SearchPage(),
    const FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticlesController articlesController =
        Get.find<ArticlesController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        if (articlesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              _buildDetailedArticles(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            offset: Offset(0, 0),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Space News',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
            IconButton(
              icon: Icon(
                isDarkMode(context) ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                bool isDarkMode = Get.isDarkMode;
                Get.changeThemeMode(
                    isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedArticles() {
    final ArticlesController articlesController =
        Get.find<ArticlesController>();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Articles',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articlesController.articles.length,
            itemBuilder: (context, index) {
              final article = articlesController.articles[index];
              return ArticleCard(
                imageUrl: article.imageUrl,
                title: article.title,
                summary: article.summary,
                publishedAt: article.publishedAt,
                article: article,
                isFavorited: RxBool(articlesController
                    .isFavorite(articlesController.articles[index])),
              );
            },
          ),
        ],
      ),
    );
  }

  bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:space_news_aggregator/controllers/article_controller.dart';
// import 'package:space_news_aggregator/pages/favorites_screen.dart';
// import 'package:space_news_aggregator/pages/search_screen.dart';
// import 'package:space_news_aggregator/widgets/article_card.dart';
// import 'package:space_news_aggregator/widgets/navigation_bar.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   final Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
//   bool isDarkMode = systemBrightness == Brightness.dark;

//   final ArticlesController articlesController = Get.put(ArticlesController());

//   final List<Widget> _pages = [
//     const HomeContentPage(),
//     SearchPage(),
//     const FavoritesPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContentPage extends StatelessWidget {
//   const HomeContentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ArticlesController articlesController =
//         Get.find<ArticlesController>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         if (articlesController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildAppBar(),
//               _buildDetailedArticles(),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildAppBar() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x1F000000),
//             offset: Offset(0, 0),
//             blurRadius: 3,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 25, 16, 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Space News',
//               style: GoogleFonts.roboto(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//                 color: Colors.black,
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.light_mode),
//               onPressed: () {
//                 isDarkMode = !isDarkMode;
//                 Get.changeTheme(
//                     isDarkMode ? ThemeData.dark() : ThemeData.light());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailedArticles() {
//     final ArticlesController articlesController =
//         Get.find<ArticlesController>();

//     return Container(
//       margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Featured Articles',
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.w500,
//               fontSize: 18,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 8),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: articlesController.articles.length,
//             itemBuilder: (context, index) {
//               final article = articlesController.articles[index];
//               return ArticleCard(
//                 imageUrl: article.imageUrl,
//                 title: article.title,
//                 summary: article.summary,
//                 publishedAt: article.publishedAt,
//                 article: article,
//                 isFavorited: RxBool(articlesController
//                     .isFavorite(articlesController.articles[index])),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
