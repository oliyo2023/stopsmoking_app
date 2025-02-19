import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:jieyan_app/config.dart';

class DeepSeekService extends GetxService {
  final String apiKey; // DeepSeek API 密钥

  DeepSeekService({required this.apiKey});

  Future<DeepSeekService> init() async {
    // 在这里可以进行一些初始化操作，比如验证 API key
    return this;
  }

  Future<String> getChatResponse(String message) async {
    final response = await http.post(
      Uri.parse('$deepSeekBaseUrl/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek', // 或者其他你想要使用的模型
        'messages': [
          {'role': 'user', 'content': message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content']; // 获取 DeepSeek 的回复
    } else {
      throw Exception('Failed to get response: ${response.statusCode}'); // 处理错误
    }
  }
}
