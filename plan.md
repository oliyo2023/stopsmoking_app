# DeepSeek API 集成计划 (聊天机器人功能)

本计划概述了将 DeepSeek API 集成到项目中以实现聊天机器人功能的步骤。

## 1. 获取 DeepSeek API 密钥

*   访问 DeepSeek 官方网站 ([https://platform.deepseek.com/](https://platform.deepseek.com/)) 并注册/登录。
*   在 API 密钥管理页面创建一个新的 API 密钥。
*   **重要提示:** 请妥善保管您的 API 密钥,不要将其公开或提交到版本控制系统。

## 2. 添加依赖项

*   在 `pubspec.yaml` 文件中添加 `http` 包:

```yaml
dependencies:
  http: ^1.2.0 # 或者更新的版本
  # 其他已有的依赖
```
*   运行 `flutter pub get` 来安装依赖项。

## 3. 创建 DeepSeekService 类

*   创建一个名为 `deepseek_service.dart` 的文件 (例如,在 `lib/services/` 目录下)。
*   在该文件中定义 `DeepSeekService` 类,负责处理与 DeepSeek API 的交互:

```dart
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
```

## 4. 创建 Chatbot UI (ChatPage)

*   创建一个名为 `chat_page.dart` 的文件 (例如,在 `lib/pages/` 目录下)。
*   在该文件中定义 `ChatPage` Widget,用于显示聊天机器人界面:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/services/deepseek_service.dart'; // 导入 DeepSeekService

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _messages = <Map<String, String>>[].obs; // 使用 GetX 的 observable 列表
  late final DeepSeekService _deepSeekService;
    bool _isLoading = false;

  @override
  void initState() {
    super.initState();
     // 从配置文件或者安全存储中读取
    _deepSeekService = DeepSeekService(apiKey: 'YOUR_DEEPSEEK_API_KEY'); // 初始化 DeepSeekService, 替换为你的 API 密钥
  }

  Future<void> _sendMessage() async {
      if (_textController.text.isEmpty) return;

      final userMessage = _textController.text;
      _messages.add({'role': 'user', 'content': userMessage});
      _textController.clear();

      setState(() {
          _isLoading = true;
      });

      try {
          final response = await _deepSeekService.getChatResponse(userMessage);
          _messages.add({'role': 'assistant', 'content': response});
      } catch (e) {
          Get.snackbar('Error', 'Failed to get response: $e',
              backgroundColor: Colors.red, colorText: Colors.white);
          // 可以添加更详细的错误处理,例如重试机制
      } finally {
          setState(() {
              _isLoading = false;
          });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DeepSeek Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder( // 使用 Obx 来响应 _messages 的变化
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['content']!,
                      textAlign: message['role'] == 'user'
                          ? TextAlign.right
                          : TextAlign.left),
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  icon: _isLoading ? CircularProgressIndicator() : Icon(Icons.send),
                  onPressed: _isLoading? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

## 5. 状态管理 (GetX)

*   在 `ChatPage` 中,我们已经使用了 GetX 的 `obs` 来管理消息列表。
*   可以根据需要添加更多的 GetX controller 和 bindings 来管理聊天机器人的其他状态。

## 6. 错误处理

*   在 `DeepSeekService` 和 `ChatPage` 中都已经包含了基本的错误处理。
*   可以根据需要添加更详细的错误处理,例如:
    *   显示更友好的错误消息。
    *   实现重试机制。
    *   记录错误日志。

## 7. 配置

*   DeepSeek API 密钥应该存储在安全的地方,例如:
    *   使用环境变量。
    *   使用 Flutter 的安全存储插件。
    *   不要直接硬编码在代码中。
    *   在 `config.dart` 文件中添加一个配置项来存储 API 密钥(但不要将该文件提交到版本控制)。

## 8. 路由
*   在 `main.dart` 中添加路由
```
GetPage(name: '/chat', page: () => ChatPage()),
```

## 后续步骤

*   根据实际需求,可以进一步完善聊天机器人的功能,例如:
    *   添加消息气泡。
    *   支持多轮对话。
    *   添加语音输入/输出。
    *   集成到应用程序的其他部分。