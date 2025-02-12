import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArticleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: GetBuilder<ArticleController>(
        builder: (controller) {
          if (controller.isLoading && controller.page == 1) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.articles.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          return ListView.builder(
            itemCount:
                controller.articles.length + (controller.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.articles.length) {
                final article = controller.articles[index];
                return ListTile(
                  title: Text(article.getStringValue('title')),
                  onTap: () {
                    Get.to(() => ArticleDetailPage(articleId: article.id));
                  },
                );
              } else {
                Future.microtask(() => controller.loadMoreArticles());
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
