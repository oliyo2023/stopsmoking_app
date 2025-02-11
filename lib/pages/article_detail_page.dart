import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';

class ArticleDetailPage extends StatelessWidget {
  final String? articleId = Get.parameters['id'];

  ArticleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticleController articleController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
      ),
      body: FutureBuilder(
        future: articleController.getArticleById(articleId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Article not found.'));
          } else {
            final article = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.data['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    article.data['content'] ?? 'No Content',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
