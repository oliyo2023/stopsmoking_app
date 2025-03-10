import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/settings_controller.dart';

class MyPage extends GetView<SettingsController> {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          value: controller.isChatVisible,
          onChanged: (value) => controller.toggleChatVisibility(),
        ));
  }
}
