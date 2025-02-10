import 'package:flutter/material.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late final PocketBaseService _pbService;

  @override
  void initState() {
    super.initState();
    _pbService = PocketBaseService(); // Initialize PocketBaseService
  }

  Future<void> _logout() async {
    _pbService.pb.authStore.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Page'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Article Page!'),
      ),
    );
  }
}
