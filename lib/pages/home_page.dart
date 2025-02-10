import 'package:flutter/material.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/profile_page.dart';
// Import LoginPage
// Import RegisterPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PocketBaseService _pbService;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _pbService = Get.find();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (_pbService.pb.authStore.isValid) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒言'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Study Section (Always visible)
          Center(child: Text('首页内容')), // Changed text to 首页内容

          // My Section (Conditionally visible)
          _isLoggedIn
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
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页', // Updated label to 首页
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的', // Updated label to 我的
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
