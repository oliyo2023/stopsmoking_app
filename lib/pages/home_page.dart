import 'package:flutter/material.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/progress_page.dart';

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

  String _currentDate = ''; // 当前日期

  @override
  void initState() {
    super.initState();
    _pbService = Get.find(); // 获取 PocketBaseService 实例
    _checkLoginStatus(); // 检查登录状态
    _currentDate =
        DateTime.now().toString().split(' ')[0]; // 获取当前日期 (YYYY-MM-DD)
  }

  /// 检查用户登录状态
  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      // 如果用户已登录
      setState(() {
        _isLoggedIn = true; // 设置 _isLoggedIn 为 true
      });
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
      body: IndexedStack(
        index: _selectedIndex, // 根据 _selectedIndex 显示不同的页面
        children: [
          // 学习区 (始终可见)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('今日戒烟进度',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (!mounted) {
                      return; // 异步操作前检查是否 mounted
                    }
                    try {
                      await _pbService.submitCheckin(
                        date: _currentDate,
                        smokeCount: 0, // 测试用默认值
                        reason: '无', // 测试用默认值
                      );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('打卡成功!')),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('打卡失败,请重试!')),
                        );
                      }
                    }
                  },
                  child: const Text('每日打卡'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/plan'); // 跳转到戒烟计划页面
                  },
                  child: const Text('查看戒烟计划'),
                ),
              ],
            ),
          ),
          const ArticlePage(), // 文章页面
          const ProgressPage(), // 进度页面
          // 我的区域 (根据登录状态条件显示)
          _MySection(isLoggedIn: _isLoggedIn),
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
        selectedItemColor: Colors.amber[800], // 选中项的颜色
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
