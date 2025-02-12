import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {
  final PocketBaseService pbService = PocketBaseService();
  final _articles = <RecordModel>[].obs;
  final _isLoading = true.obs;
  final _hasMore = true.obs;
  final _page = 1.obs;

  List<RecordModel> get articles => _articles;
  bool get isLoading => _isLoading.value;
  bool get hasMore => _hasMore.value;
  int get page => _page.value;

  ArticleController() {
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final records = await pbService.getArticles(_page.value, 10);
      _articles.addAll(records);
      _isLoading.value = false;
      _hasMore.value = records.isNotEmpty;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // Handle error (e.g., show a snackbar)
    }
  }

  Future<void> loadMoreArticles() async {
    if (_isLoading.value || !_hasMore.value) return;
    _isLoading.value = true;
    update();
    _page.value = _page.value + 1;
    try {
      final records = await pbService.getArticles(_page.value, 10);
      _articles.addAll(records);
      _isLoading.value = false;
      _hasMore.value = records.isNotEmpty;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // Handle error (e.g., show a snackbar)
    }
  }
}
