import 'package:flutter/material.dart';
import 'package:jieyan_app/providers/article_provider.dart';
import 'package:jieyan_app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:jieyan_app/app_routes.dart';
import 'package:jieyan_app/services/deepseek_service.dart';
import 'package:jieyan_app/providers/user_provider.dart';
// import 'package:jieyan_app/providers/article_provider.dart';

/// 初始化所有服务
Future<void> initServices() async {
  // 初始化 PocketBaseService
  await Get.putAsync(() => PocketBaseService().init());
  // 初始化 UserProvider
  Get.put(UserProvider());
  // 初始化 ArticleProvider
  Get.put(ArticleProvider());
  // 异步初始化 DeepSeekService
  await Get.putAsync(() => DeepSeekService(
          apiKey:
              "MFVE5OIQGe1tKxuPHxXbJRnGlcNe4Qw8DNyo81xNLcp0jNf1DemfjXHGr+eUonZM")
      .init());
}

/// 主函数,程序入口
void main() async {
  // 确保 Flutter 引擎已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化所有服务
  await initServices();
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
      title: 'AI戒烟', // 应用标题
      debugShowCheckedModeBanner: false, // 是否显示 debug 横幅
      theme: appTheme, // 应用主题
      darkTheme: appTheme, // 暗黑模式主题 (与亮色主题相同)
      themeMode: ThemeMode.system, // 主题模式 (跟随系统)
      initialRoute: '/home', // 初始路由
      getPages: AppRoutes.routes,
    );
  }
}
