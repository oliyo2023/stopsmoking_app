import 'package:get/get.dart';
import 'package:jieyan_app/bindings/article_binding.dart';
import 'package:jieyan_app/controllers/chat_controller.dart';
import 'package:jieyan_app/controllers/interactive_calendar_controller.dart';
import 'package:jieyan_app/controllers/plan_controller.dart';
import 'package:jieyan_app/providers/user_provider.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/login_page.dart';
import 'package:jieyan_app/pages/register_page.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/plan_page.dart';
import 'package:jieyan_app/pages/chat_page.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';
import 'package:jieyan_app/pages/edit_profile_page.dart';
import 'package:jieyan_app/controllers/settings_controller.dart';
import 'package:jieyan_app/pages/membership_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String articleDetail = '/article_detail';
  static const String editProfile = '/edit_profile';
  static const String membership = '/membership';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      bindings: [
        BindingsBuilder(() {
          Get.put(InteractiveCalendarController());
        }),
        BindingsBuilder(() {
          Get.put(SettingsController());
        }),
      ],
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(UserProvider());
      }),
    ),
    GetPage(name: '/register', page: () => RegisterPage()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
    GetPage(
      name: '/plan',
      page: () => PlanPage(),
      binding: BindingsBuilder(() {
        Get.put(PlanController());
      }),
    ),
    GetPage(
      name: '/chat',
      page: () => const ChatPage(),
      binding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
    ),
    GetPage(name: '/article', page: () => const ArticlePage()),
    GetPage(
      name: '/article_detail/:articleId',
      page: () => ArticleDetailPage(articleId: Get.parameters['articleId']!),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: membership,
      page: () => const MembershipPage(),
    ),
  ];
}
