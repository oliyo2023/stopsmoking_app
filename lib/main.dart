import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/plan_page.dart';
import 'package:jieyan_app/pages/progress_page.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/pages/my_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '戒烟APP',
      theme: appTheme,
      home: MainPage(),
      debugShowCheckedModeBanner: false, // Remove debug banner
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
      // appBar: AppBar( // Remove AppBar
      //   title: const Text('戒烟APP'),
      // ),
      body: Center(
        child: Obx(() => [
              HomePage(),
              PlanPage(),
              ProgressPage(),
              ArticlePage(),
              MyPage(),
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
                label: '学习',
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
