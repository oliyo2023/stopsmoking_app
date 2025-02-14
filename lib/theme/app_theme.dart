import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF6A1B9A),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFF6A1B9A), // 深紫色
    secondary: Color(0xFF9C27B0), // 中等紫色
    surface: Colors.white, // 浅紫色背景
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF6A1B9A),
    unselectedItemColor: Colors.grey,
  ),
);
