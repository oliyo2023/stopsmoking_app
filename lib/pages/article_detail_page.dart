import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/article_controller.dart';

/// 文章详情页面
class ArticleDetailPage extends StatefulWidget {
  /// 文章 ID
  final String articleId;

  /// 构造函数
  /// 输入参数:
  ///   articleId: 文章 ID (String)
  const ArticleDetailPage({super.key, required this.articleId});

  @override
  ArticleDetailPageState createState() => ArticleDetailPageState();
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  /// 文章控制器实例
  late final ArticleController _articleController;

  @override
  void initState() {
    super.initState();
    // 使用 Get.put() 创建 ArticleController 实例,并进行依赖注入
    _articleController = Get.put(ArticleController());
    // 调用控制器的 getArticleById 方法获取文章详情
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _articleController.getArticleById(widget.articleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Obx(() {
        // 使用 Obx 监听 _articleController 的变化
        if (_articleController.isLoading) {
          // 如果正在加载,显示加载指示器
          return const Center(child: CircularProgressIndicator());
        }

        if (_articleController.article == null) {
          // 如果文章为空,显示 "文章未找到"
          return const Center(child: Text('Article not found.'));
        }

        // 获取文章
        final article = _articleController.article!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 显示文章标题
              Text(
                article.getStringValue('title'),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 显示文章内容
              Text(article.getStringValue('content')),
            ],
          ),
        );
      }),
    );
  }
}
