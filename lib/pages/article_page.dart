import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({Key? key}) : super(key: key);

  final ArticleController articleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Obx(() {
        if (articleController.isLoading &&
            articleController.articleList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (articleController.articleList.isEmpty) {
          return Center(child: Text('No articles found.'));
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  articleController.hasMore) {
                articleController.loadMoreArticles();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                articleController.currentPage = 1;
                articleController.articleList.clear();
                await articleController.fetchArticles();
              },
              child: ListView.builder(
                itemCount: articleController.articleList.length +
                    (articleController.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == articleController.articleList.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final article = articleController.articleList[index];
                  return Card(
                    child: ListTile(
                      title: Text(article.data['title'] ?? 'No Title'),
                      onTap: () {
                        Get.toNamed('/article/${article.id}');
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
