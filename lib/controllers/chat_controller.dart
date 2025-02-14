import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/deepseek_service.dart';

class ChatController extends GetxController {
  final textController = TextEditingController();
  final messages = <Map<String, String>>[].obs;
  late final DeepSeekService deepSeekService;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize DeepSeekService here
    deepSeekService = DeepSeekService(
        apiKey:
            'MFVE5OIQGe1tKxuPHxXbJRnGlcNe4Qw8DNyo81xNLcp0jNf1DemfjXHGr+eUonZM'); // Replace with your actual API key
  }

  Future<void> sendMessage() async {
    if (textController.text.isEmpty) return;

    final userMessage = textController.text;
    messages.add({'role': 'user', 'content': userMessage});
    textController.clear();

    isLoading.value = true;

    try {
      final response = await deepSeekService.getChatResponse(userMessage);
      messages.add({'role': 'assistant', 'content': response});
    } catch (e) {
      Get.snackbar('Error', 'Failed to get response: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
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
