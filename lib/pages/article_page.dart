import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';

class ArticlePage extends StatelessWidget {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: GetBuilder<ArticleController>(
        builder: (controller) {
          if (controller.isLoading && controller.page == 1) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.articles.isEmpty) {
            return Center(child: Text('No articles found.'));
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
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
