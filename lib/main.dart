import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/pages/home_page.dart';
import 'package:jieyan_app/pages/login_page.dart';
import 'package:jieyan_app/pages/register_page.dart';
import 'package:jieyan_app/theme/app_theme.dart'; // Import AppTheme
import 'package:jieyan_app/services/pocketbase_service.dart';

void main() {
  Get.put(PocketBaseService()); // Put PocketBaseService into GetX
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // No need to check auth status for initial route anymore
  // final PocketBaseService _pbService = Get.find();
  // bool _isAuthenticated = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkAuthStatus();
  // }

  // Future<void> _checkAuthStatus() async {
  //   if (_pbService.pb.authStore.isValid) {
  //     setState(() {
  //       _isAuthenticated = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      initialRoute: '/home', // Always start at /home
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
