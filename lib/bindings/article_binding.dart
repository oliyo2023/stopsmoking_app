import 'package:get/get.dart';
import 'package:jieyan_app/providers/article_provider.dart';
import 'package:jieyan_app/controllers/article_controller.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleProvider>(() => ArticleProvider());
    Get.lazyPut<ArticleController>(() => ArticleController());
  }
}
