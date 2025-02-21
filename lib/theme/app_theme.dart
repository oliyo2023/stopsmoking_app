import 'package:flutter/material.dart';

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
