import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {
  final PocketBaseService pbService = PocketBaseService();
  final _articles = <RecordModel>[].obs;
  final _isLoading = true.obs;
  final _hasMore = true.obs;
  final _page = 1.obs;

  List<RecordModel> get articles => _articles.value;
  bool get isLoading => _isLoading.value;
  bool get hasMoreArticles => _hasMore.value;
  int get page => _page.value;

  // Public methods to access private members
  List<RecordModel> get articleList => _articles.value;
  bool get hasMore => _hasMore.value;
  int get currentPage => _page.value;
  set page(int value) => _page.value = value;
  set currentPage(int value) => _page.value = value;
  ArticleController() {
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final records = await pbService.pb.collection('posts').getList(
          page: _page.value,
          perPage: 10,
          fields: 'id,title,created,updated'); // Exclude content field
      _articles.addAll(records.items);
      _isLoading.value = false;
      _hasMore.value = records.items.isNotEmpty;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // Handle error (e.g., show a snackbar)
      print(e);
    }
  }

  Future<void> loadMoreArticles() async {
    if (_isLoading.value || !_hasMore.value) return;
    _isLoading.value = true;
    update();
    _page.value = _page.value + 1;
    try {
      final records = await pbService.pb.collection('posts').getList(
          page: _page.value,
          perPage: 10,
          fields: 'id,title,created,updated'); // Exclude content field
      _articles.addAll(records.items);
      _isLoading.value = false;
      _hasMore.value = records.items.isNotEmpty;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // Handle error (e.g., show a snackbar)
      print(e);
    }
  }

  Future<RecordModel?> getArticleById(String id) async {
    try {
      final record = await pbService.pb.collection('posts').getOne(id);
      return record;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
