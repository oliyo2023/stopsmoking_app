import 'package:get/get.dart';

class SettingsController extends GetxController {
  // AI 聊天功能开关状态
  final RxBool enableAIChat = false.obs;

  // 切换 AI 聊天功能开关
  void toggleAIChat(bool value) {
    enableAIChat.value = value;
  }
}