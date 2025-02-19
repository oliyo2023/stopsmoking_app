import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1976D2),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFF1976D2), // 深蓝色
    secondary: Color(0xFF2196F3), // 中等蓝色
    surface: Colors.white, // 白色背景
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF1976D2),
    unselectedItemColor: Colors.grey,
  ),
);
