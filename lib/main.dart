import 'package:flutter/material.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/login_page.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/register_page.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';
import 'package:jieyan_app/controllers/article_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize PocketBaseService here
  final pbService = PocketBaseService();
  // Removed: await pbService.init(); // No init method in PocketBaseService
  Get.put(pbService); // Register PocketBaseService with GetX
  Get.put(ArticleController()); // Register ArticleController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '戒烟 App',
      theme: appTheme,
      darkTheme: appTheme, // Use the same theme for dark theme
      themeMode: ThemeMode.system,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(name: '/article/:id', page: () => ArticleDetailPage()),
      ],
    );
  }
}
