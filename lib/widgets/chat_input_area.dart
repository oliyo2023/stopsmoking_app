import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/chat_controller.dart';

class ChatInputArea extends StatelessWidget {
  const ChatInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: const InputDecoration(
                hintText: '请输入您的消息...',
              ),
            ),
          ),
          Obx(
            () => IconButton(
              icon: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.send),
              onPressed:
                  controller.isLoading.value ? null : controller.sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
