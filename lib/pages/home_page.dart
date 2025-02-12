import 'package:flutter/material.dart';
import 'package:jieyan_app/pages/article_page.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/progress_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PocketBaseService _pbService;
  bool _isLoggedIn = false;

  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _pbService = Get.find();
    _checkLoginStatus();
    _currentDate = DateTime.now().toString().split(' ')[0];
  }

  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Study Section (Always visible)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('今日戒烟进度',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _pbService.submitCheckin(
                        date: _currentDate,
                        smokeCount: 0, // Default value for testing
                        reason: '无', // Default value for testing
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('打卡成功!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('打卡失败,请重试!')),
                      );
                    }
                  },
                  child: Text('每日打卡'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          ArticlePage(),
          ProgressPage(),
          // My Section (Conditionally visible)
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class _MySection extends StatelessWidget {
  const _MySection({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? ProfilePage() // Display ProfilePage when logged in
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('请先登录以查看个人信息'), // Updated text to Chinese
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text('登录'), // Updated text to Chinese
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: Text('注册'), // Updated text to Chinese
                ),
              ],
            ),
          );
  }
}
