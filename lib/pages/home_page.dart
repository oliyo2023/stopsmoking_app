import 'package:flutter/material.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';

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
    _pbService = Get.find(); // Use Get.find() to retrieve the instance
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
          Center(child: Text('Study Section')),

          // My Section (Conditionally visible)
          _isLoggedIn
              ? Center(child: Text('My Section'))
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    child: Text('Login to access My Section'),
                  ),
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '学习',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
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
