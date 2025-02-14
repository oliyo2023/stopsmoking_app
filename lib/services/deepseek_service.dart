import 'package:http/http.dart' as http;
import 'dart:convert';

class DeepSeekService {
  final String apiKey; // DeepSeek API 密钥
  final String baseUrl = 'https://api.deepseek.com/v1'; // DeepSeek API 基础 URL

  DeepSeekService({required this.apiKey});

  Future<String> getChatResponse(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek-chat', // 或者其他你想要使用的模型
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
