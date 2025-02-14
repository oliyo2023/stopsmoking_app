import 'package:flutter/material.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:jieyan_app/app_routes.dart';

/// 主函数,程序入口
void main() async {
  // 确保 Flutter 引擎已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化 PocketBaseService
  final pbService = PocketBaseService();
  // 使用 GetX 注册 PocketBaseService,以便全局访问
  Get.put(pbService);
  // 初始化 AppRoutes

  // 运行应用
  runApp(const MyApp());
}

/// 应用主类
class MyApp extends StatelessWidget {
  /// 构造函数
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 GetMaterialApp 作为根 Widget,支持 GetX 的路由和依赖注入
    return GetMaterialApp(
      title: '戒烟 App', // 应用标题
      debugShowCheckedModeBanner: false, // 是否显示 debug 横幅
      theme: appTheme, // 应用主题
      darkTheme: appTheme, // 暗黑模式主题 (与亮色主题相同)
      themeMode: ThemeMode.system, // 主题模式 (跟随系统)
      initialRoute: '/home', // 初始路由
      getPages: AppRoutes.routes,
    );
  }
}
