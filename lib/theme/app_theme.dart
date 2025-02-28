import 'package:flutter/material.dart';

/// 应用主题颜色定义
class AppColors {
  // 背景色
  static const backgroundColor = Color(0xFFF5F5F5);
  
  // 文字颜色
  static const textPrimary = Colors.black;
  static const textSecondary = Color(0xFF757575);
  
  // 按钮颜色
  static const buttonPrimary = Colors.blue;
  
  // 会员卡渐变色
  static const membershipGradientStart = Color(0xFF1E88E5);
  static const membershipGradientEnd = Color(0xFF1565C0);
  
  // 导航栏选中颜色
  static const navSelected = Colors.blue;
  
  // 服务图标颜色
  static const serviceOrange = Colors.orange;
  static const serviceGreen = Colors.green;
  static const servicePurple = Colors.purple;
  static const serviceBlue = Colors.blue;
  static const serviceRed = Colors.red;
  static const servicePink = Colors.pink;
  static const serviceTeal = Colors.teal;
  static const serviceAmber = Colors.amber;
  static const serviceIndigo = Colors.indigo;
  static const serviceDeepPurple = Colors.deepPurple;
  
  // Snackbar 颜色
  static const snackbarError = Color(0xFFD32F2F); // 错误提示背景色
  static const snackbarText = Colors.white; // Snackbar 文字颜色
}

final appTheme = ThemeData(
  brightness: Brightness.light, // 修改为亮色主题以适应蓝色调色板
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue, // 修改为蓝色
  ),
  colorScheme: const ColorScheme(
    primary: Colors.blue, // 主要颜色为蓝色
    secondary: Colors.blueAccent, // 次要颜色为蓝色的强调色
    surface: Colors.white, // 背景颜色为白色
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light, // 确保亮度为亮色
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue, // 修改为与主要颜色一致
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white, // 修改为白色
  ),
);
