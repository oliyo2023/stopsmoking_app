// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/progress_page.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/controllers/interactive_calendar_controller.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:jieyan_app/widgets/user_info_section.dart';
import 'package:jieyan_app/widgets/daily_checkin_section.dart';
import 'package:jieyan_app/widgets/quit_plan_section.dart';
import 'package:jieyan_app/widgets/recommended_articles_section.dart';
import 'package:jieyan_app/widgets/health_data_section.dart';
import 'package:jieyan_app/controllers/settings_controller.dart';

// 使用从 health_data_section.dart 导入的 HealthDataModel 类

/// 首页
class HomePage extends GetView<SettingsController> {
  /// 构造函数
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PocketBaseService pbService = Get.find(); // 获取 PocketBaseService 实例
    final InteractiveCalendarController calendarController =
        Get.find(); // 初始化 InteractiveCalendarController
    final ValueNotifier<int> selectedIndex =
        ValueNotifier<int>(0); // 当前选中的底部导航栏索引
// 用户是否已登录
    final ValueNotifier<RecordModel?> userInfo =
        ValueNotifier<RecordModel?>(null); // 用户信息
    final ValueNotifier<String> currentDate =
        ValueNotifier<String>(DateTime.now().toString().split(' ')[0]); // 当前日期
    final ValueNotifier<List<RecordModel>> recommendedArticles =
        ValueNotifier<List<RecordModel>>([]); // 推荐文章列表
    final List<HealthDataModel> healthData = [
      // Mock 健康数据
      HealthDataModel(name: '心率', value: 72.0, unit: 'bpm', trend: 'stable'),
      HealthDataModel(name: '血压', value: 120.0, unit: 'mmHg', trend: 'down'),
      HealthDataModel(name: '肺活量', value: 4.5, unit: 'L', trend: 'up'),
    ];

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, selectedIndex, child) {
              return IndexedStack(
                index: selectedIndex, // 根据 _selectedIndex 显示不同的页面
                children: [
                  // 首页 (重新设计的首页)
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<RecordModel?>(
                            valueListenable: userInfo,
                            builder: (context, userInfo, child) {
                              return UserInfoSection(userInfo: userInfo);
                            },
                          ),
                          const SizedBox(height: 24),
                          DailyCheckinSection(onCheckin: () async {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            try {
                              await pbService.submitCheckin(
                                date: currentDate.value,
                                smokeCount: 0, // 测试用默认值
                                reason: '无', // 测试用默认值
                              );
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(content: Text('打卡成功!')),
                              );
                              calendarController.fetchCheckinData(); // 更新日历显示
                            } catch (e) {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(content: Text('打卡失败,请重试!')),
                              );
                            }
                          }),
                          const SizedBox(height: 24),
                          const QuitPlanSection(),
                          const SizedBox(height: 24),
                          ValueListenableBuilder<List<RecordModel>>(
                            valueListenable: recommendedArticles,
                            builder: (context, recommendedArticles, child) {
                              return RecommendedArticlesSection(
                                  recommendedArticles: recommendedArticles);
                            },
                          ),
                          const SizedBox(height: 24),
                          HealthDataSection(healthData: healthData),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  const ArticlePage(),
                  const ProgressPage(),
                  _MySection(isLoggedIn: true),
                ],
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Obx(() => Visibility(
                  visible: controller.isChatVisible,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed('/chat');
                    },
                    child: const Icon(Icons.chat),
                  ),
                )),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: '学习',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                label: '进度',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '我的',
              ),
            ],
            currentIndex: selectedIndex, // 当前选中的索引
            selectedItemColor: AppColors.navSelected, // 选中项的颜色
            onTap: (index) {
              selectedIndex.value = index; // 使用 ValueNotifier 的 value 属性
            }, // 点击事件处理
          );
        },
      ),
    );
  }
}

/// "我的" 区域 Widget
class _MySection extends StatelessWidget {
  /// 构造函数
  const _MySection({
    required this.isLoggedIn,
  });

  /// 用户是否已登录
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? const ProfilePage() // 如果已登录,显示 ProfilePage
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('请先登录以查看个人信息'), // 提示用户登录
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login'); // 跳转到登录页面
                  },
                  child: const Text('登录'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register'); // 跳转到注册页面
                  },
                  child: const Text('注册'),
                ),
              ],
            ),
          );
  }
}
