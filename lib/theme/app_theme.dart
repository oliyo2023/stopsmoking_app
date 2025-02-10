import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: Color(0xFF6A1B9A), // 深紫色
    secondary: Color(0xFF9C27B0), // 中等紫色
    surface: Colors.white,
    background: Color(0xFFF3E5F5), // 浅紫色背景
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF6A1B9A),
    unselectedItemColor: Colors.grey,
  ),
);