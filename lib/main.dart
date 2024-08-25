import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:space_news_aggregator/controllers/article_controller.dart';
import 'package:space_news_aggregator/controllers/favorite_controller.dart';
import 'package:space_news_aggregator/databases/objectbox.dart';
import 'package:space_news_aggregator/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  try {
    final objectBox = await ObjectBox.create();
    Get.put(objectBox);
    Get.put(ArticlesController());
    Get.put(FavoritesController());
    runApp(const MyApp(permissionGranted: true));
  } catch (e) {
    runApp(const MyApp(permissionGranted: false));
  }
}

class MyApp extends StatelessWidget {
  final bool permissionGranted;

  const MyApp({super.key, required this.permissionGranted});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space News Aggregator App',
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1B263B),
      hintColor: const Color(0xFF00FFDD),
      scaffoldBackgroundColor: const Color(0xFFF0F0F0),
      canvasColor: const Color(0xFFFFFFFF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF0D1B2A),
      hintColor: const Color(0xFF00FFDD),
      scaffoldBackgroundColor: const Color(0xFF1B263B),
      canvasColor: const Color(0xFF0D1B2A),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF00FFDD),
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0D1B2A),
      ),
    );
  }
}
