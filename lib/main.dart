import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/login_page.dart';
import 'package:jieyan_app/pages/register_page.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/plan_page.dart'; // Import PlanPage
import 'package:jieyan_app/pages/progress_page.dart'; // Import ProgressPage
import 'package:jieyan_app/pages/article_page.dart'; // Import ArticlePage
import 'package:jieyan_app/pages/my_page.dart'; // Import MyPage

void main() {
  Get.put(PocketBaseService());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'stop smoking',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set initialRoute to '/'
      routes: {
        '/': (context) => MainPage(), // Route '/' to MainPage
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        // '/home': (context) => const HomePage(), // Remove '/home' route
        '/profile': (context) => const ProfilePage(),
        '/plan': (context) => const PlanPage(), // PlanPage route
        '/progress': (context) => const ProgressPage(), // ProgressPage route
        '/article': (context) => const ArticlePage(), // ArticlePage route
        '/my': (context) => const MyPage(), // MyPage route
      },
    );
  }
}

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

class MainPage extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => [
              HomePage(), // 首页
              PlanPage(), // 计划页
              ProgressPage(), // 进度页
              ArticlePage(), // 文章页
              MyPage(), // 我的页
            ][controller.selectedIndex.value]),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: '计划',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                label: '进度',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: '文章',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '我的',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: appTheme.colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: controller.onItemTapped,
          )),
    );
  }
}
