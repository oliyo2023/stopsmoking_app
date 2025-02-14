import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/chat_controller.dart';
import 'package:jieyan_app/widgets/ai_message_bubble.dart';
import 'package:jieyan_app/widgets/user_message_bubble.dart';
import 'package:jieyan_app/widgets/chat_input_area.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('你是哪个？'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'about') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('关于'),
                    content: const Text('这是一个聊天应用程序。'),
                    actions: [
                      TextButton(
                        child: const Text('关闭'),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'about',
                child: Text('关于'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('新的聊天'),
                  content: const Text('开始新的聊天？'),
                  actions: [
                    TextButton(
                        child: const Text('确认'),
                        onPressed: () {
                          controller.messages.clear();
                          Get.back();
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  if (message['role'] == 'user') {
                    return UserMessageBubble(message: message['content']!);
                  } else {
                    return AIMessageBubble(message: message['content']!);
                  }
                },
              ),
            ),
          ),
          const ChatInputArea(),
        ],
      ),
    );
  }
}
