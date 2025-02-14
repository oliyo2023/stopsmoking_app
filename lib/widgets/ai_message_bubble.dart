import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/chat_controller.dart';
import 'package:flutter/services.dart';

class AIMessageBubble extends StatelessWidget {
  final String message;

  const AIMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message));
                    Get.snackbar('已复制', '消息已复制到剪贴板');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    final controller = Get.find<ChatController>();
                    if (controller.messages.isNotEmpty) {
                      String lastUserMessage = "";
                      // Iterate backwards to find the last user message.
                      for (int i = controller.messages.length - 1;
                          i >= 0;
                          i--) {
                        if (controller.messages[i]['role'] == 'user') {
                          lastUserMessage = controller.messages[i]['content']!;
                          break;
                        }
                      }
                      if (lastUserMessage.isNotEmpty) {
                        controller.textController.text = lastUserMessage;
                        controller.sendMessage();
                      }
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    Get.snackbar('反馈', '已记录点赞！');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.thumb_down),
                  onPressed: () {
                    Get.snackbar('反馈', '已记录点踩！');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
