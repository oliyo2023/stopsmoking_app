import 'package:get/get.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/login_page.dart';
import 'package:jieyan_app/pages/register_page.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/plan_page.dart';
import 'package:jieyan_app/pages/chat_page.dart';
import 'package:jieyan_app/controllers/login_controller.dart';
import 'package:jieyan_app/controllers/article_controller.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/home', page: () => const HomePage()),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
    GetPage(name: '/plan', page: () => const PlanPage()),
    GetPage(name: '/chat', page: () => const ChatPage()),
    GetPage(
      name: '/article',
      page: () => const ArticlePage(),
      binding: BindingsBuilder(() {
        Get.put(ArticleController());
      }),
    ),
    GetPage(
        name: '/article_detail/:articleId',
        page: () => ArticleDetailPage(articleId: Get.parameters['articleId']!),
        binding: BindingsBuilder(() {
          Get.put(ArticleController());
        })),
  ];
}
