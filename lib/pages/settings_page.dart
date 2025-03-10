import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  Widget _buildAIChatSwitch() {
    return Obx(() => SwitchListTile(
          title: const Text('启用AI聊天助手'),
          value: controller.isChatVisible,
          onChanged: (value) {
            controller.saveChatVisibility(value);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAIChatSwitch(),
          ],
        ),
      ),
    );
  }
}
