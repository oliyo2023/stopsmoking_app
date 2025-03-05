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
class HomePage extends StatefulWidget {
  /// 构造函数
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // 当前选中的底部导航栏索引
  late PocketBaseService _pbService; // PocketBase 服务实例
  bool _isLoggedIn = false; // 用户是否已登录
  RecordModel? _userInfo; // 用户信息
  String _currentDate = ''; // 当前日期
  final _calendarController = Get.put(
      InteractiveCalendarController()); // 初始化 InteractiveCalendarController
  List<RecordModel> _recommendedArticles = []; // 推荐文章列表
  final List<HealthDataModel> _healthData = [
    // Mock 健康数据
    HealthDataModel(name: '心率', value: 72.0, unit: 'bpm', trend: 'stable'),
    HealthDataModel(name: '血压', value: 120.0, unit: 'mmHg', trend: 'down'),
    HealthDataModel(name: '肺活量', value: 4.5, unit: 'L', trend: 'up'),
  ];

  @override
  void initState() {
    super.initState();
    _pbService = Get.find(); // 获取 PocketBaseService 实例
    _checkLoginStatus(); // 检查登录状态
    _currentDate =
        DateTime.now().toString().split(' ')[0]; // 获取当前日期 (YYYY-MM-DD)
    _fetchRecommendedArticles(); // 获取推荐文章
  }

  /// 获取用户信息
  Future<void> _fetchUserInfo() async {
    final userId = _pbService.pb.authStore.model.id;
    if (userId == null) {
      return;
    }
    final userInfo = await _pbService.getUserInfo(userId);
    setState(() {
      _userInfo = userInfo;
    });
  }

  /// 获取推荐文章
  Future<void> _fetchRecommendedArticles() async {
    final articles = await _pbService.getRecommendedArticles(2); // 获取 2 篇推荐文章
    setState(() {
      _recommendedArticles = articles;
    });
  }

  /// 提交每日打卡
  Future<void> _submitCheckin() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await _pbService.submitCheckin(
        date: _currentDate,
        smokeCount: 0, // 测试用默认值
        reason: '无', // 测试用默认值
      );
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('打卡成功!')),
      );
      _calendarController.fetchCheckinData(); // 更新日历显示
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('打卡失败,请重试!')),
      );
    }
  }

  /// 检查用户登录状态
  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      // 如果用户已登录
      setState(() {
        _isLoggedIn = true; // 设置 _isLoggedIn 为 true
      });
      _fetchUserInfo(); // 获取用户信息
    }
  }

  /// 底部导航栏点击事件处理
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 更新当前选中的索引
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex, // 根据 _selectedIndex 显示不同的页面
            children: [
              // 首页 (重新设计的首页)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoSection(userInfo: _userInfo),
                      const SizedBox(height: 24),
                      DailyCheckinSection(onCheckin: _submitCheckin),
                      const SizedBox(height: 24),
                      const QuitPlanSection(),
                      const SizedBox(height: 24),
                      RecommendedArticlesSection(
                          recommendedArticles: _recommendedArticles),
                      const SizedBox(height: 24),
                      HealthDataSection(healthData: _healthData),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const ArticlePage(),
              const ProgressPage(),
              _MySection(isLoggedIn: _isLoggedIn),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Visibility(
                visible: Get.find<SettingsController>().enableAIChat.value,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/chat');
                  },
                  child: const Icon(Icons.chat),
                ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex, // 当前选中的索引
        selectedItemColor: AppColors.navSelected, // 选中项的颜色
        onTap: _onItemTapped, // 点击事件处理
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
