import 'package:flutter/material.dart';

/// 应用主题颜色定义
class AppColors {
  // 背景色
  static const backgroundColor = Color(0xFFF5F5F5);
  
  // 文字颜色
  static const textPrimary = Colors.black;
  static const textSecondary = Color(0xFF757575);
  
  // 会员卡渐变色
  static const membershipGradientStart = Color(0xFF1E88E5);
  static const membershipGradientEnd = Color(0xFF1565C0);
  
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

  // 表单相关颜色
  static const formBorder = Colors.blue;
  static const formLabel = Colors.black87;
  static const formError = Colors.red;
  
  // 按钮颜色
  static const buttonPrimary = Colors.blue;
  static const buttonText = Colors.white;
  static const buttonDisabled = Colors.grey;
  
  // 提示信息颜色
  static const snackbarError = Colors.red;
  static const snackbarText = Colors.white;
  
  // 导航栏颜色
  static const navSelected = Color(0xFFE65100); // amber[800]
  static const navUnselected = Colors.grey;
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
