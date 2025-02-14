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
    _deepSeekService = DeepSeekService(
        apiKey:
            'sk-022b40ce70da4a4ca5e3eaeadc00ae36'); // 初始化 DeepSeekService, 替换为你的 API 密钥
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
            child: Obx(() => ListView.builder(
                  // 使用 Obx 来响应 _messages 的变化
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
                    decoration: const InputDecoration(
                        hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  icon: _isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
