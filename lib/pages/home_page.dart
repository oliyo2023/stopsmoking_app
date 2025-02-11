import 'package:flutter/material.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/profile_page.dart';
import 'package:jieyan_app/pages/progress_page.dart'; // Import ProgressPage

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
          Center(child: Text('首页内容')), // Changed text to 首页内容

          // Progress Page
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
