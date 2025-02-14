import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.lazyPut with fenix: true to preserve the controller's state
    Get.lazyPut(() => ChatController(), fenix: true);
    final controller = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DeepSeek Chatbot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return ListTile(
                    title: Text(message['content']!,
                        textAlign: message['role'] == 'user'
                            ? TextAlign.right
                            : TextAlign.left),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your message...'),
                  ),
                ),
                Obx(
                  () => IconButton(
                    icon: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
