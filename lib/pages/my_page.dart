import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/settings_controller.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 确保 SettingsController 已注册
    Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(title: const Text('我的页')),
      body: Column(
        children: [
          const Text('My Page Content'),
          _buildAIChatSwitch(),
        ],
      ),
    );
  }

  Widget _buildAIChatSwitch() {
    return Obx(() => SwitchListTile(
          title: const Text('启用AI聊天助手'),
          value: Get.find<SettingsController>().enableAIChat.value,
          onChanged: (value) =>
              Get.find<SettingsController>().toggleAIChat(value),
        ));
  }
}
