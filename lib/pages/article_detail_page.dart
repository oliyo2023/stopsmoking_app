import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;

  const ArticleDetailPage({super.key, required this.articleId});

  @override
  ArticleDetailPageState createState() => ArticleDetailPageState();
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  final PocketBaseService _pbService = PocketBaseService();
  RecordModel? _article;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchArticle();
  }

  Future<void> _fetchArticle() async {
    try {
      final article = await _pbService.getArticleById(widget.articleId);
      setState(() {
        _article = article;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Article Details'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Article Details'),
        ),
        body: Center(child: Text('Error: $_error')),
      );
    }

    if (_article == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Article Details'),
        ),
        body: const Center(child: Text('Article not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _article!.getStringValue('title'),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(_article!.getStringValue('content')),
          ],
        ),
      ),
    );
  }
}
