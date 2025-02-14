import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/deepseek_service.dart';

class ChatController extends GetxController {
  final DeepSeekService _deepSeekService = Get.find();
  final textController = TextEditingController();
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  RxBool isLoading = false.obs;

  String _formatMessagesForApi() {
    // Simple concatenation of messages.  Adjust as needed for the DeepSeek API.
    StringBuffer formatted = StringBuffer();
    for (var message in messages) {
      formatted.write(message['content']);
      formatted.write(" "); // Add space between messages
    }
    return formatted.toString();
  }

  Future<void> sendMessage() async {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }

    textController.clear();

    messages.add({'role': 'user', 'content': text});

    isLoading.value = true;
    try {
      final response =
          await _deepSeekService.getChatResponse(_formatMessagesForApi());
      messages.add({'role': 'assistant', 'content': response});
    } catch (e) {
      messages.add({'role': 'assistant', 'content': 'Error: ${e.toString()}'});
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
