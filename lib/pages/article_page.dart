import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';
import 'package:jieyan_app/pages/article_detail_page.dart';

/// 文章列表页面
class ArticlePage extends StatelessWidget {
  /// 构造函数
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 Get.put 注册 ArticleController, 确保在当前页面可以使用
    Get.put(ArticleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'), // 标题栏显示 "Articles"
      ),
      body: GetBuilder<ArticleController>(
        // 使用 GetBuilder 监听 ArticleController 的状态变化
        builder: (controller) {
          if (controller.isLoading && controller.page == 1) {
            // 如果正在加载第一页,显示加载指示器
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.articles.isEmpty) {
            // 如果文章列表为空,显示 "No articles found."
            return const Center(child: Text('No articles found.'));
          }

          final _isLoadingMore = false.obs;

          if (!_isLoadingMore.value && controller.hasMore) {
            _isLoadingMore.value = true;
            Future.microtask(() async {
              await controller.loadMoreArticles();
              _isLoadingMore.value = false;
            });
          }

          return ListView.builder(
            itemCount: controller.articles.length +
                (controller.hasMore ? 1 : 0), // 列表项数量,如果有更多数据,则加 1 (用于显示加载指示器)
            itemBuilder: (context, index) {
              if (index < controller.articles.length) {
                // 如果 index 小于文章数量,显示文章列表项
                final article = controller.articles[index];
                return ListTile(
                  title: Text(article.getStringValue('title')), // 显示文章标题
                  onTap: () {
                    // 点击列表项,跳转到文章详情页面
                    Get.to(() => ArticleDetailPage(articleId: article.id));
                  },
                );
              } else {
                // 如果 index 等于文章数量,加载更多数据,并显示加载指示器
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
