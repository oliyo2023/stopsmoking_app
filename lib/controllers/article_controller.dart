import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:get/get.dart';

/// 文章控制器,使用 GetX 管理状态
class ArticleController extends GetxController {
  /// PocketBase 服务实例
  final PocketBaseService pbService = PocketBaseService();

  /// 文章列表的可观察对象
  final _articles = <RecordModel>[].obs;

  /// 加载状态的可观察对象
  final _isLoading = true.obs;

  /// 是否有更多数据的可观察对象
  final _hasMore = true.obs;

  /// 当前页码的可观察对象
  final _page = 1.obs;

  /// 获取文章列表
  List<RecordModel> get articles => _articles;

  /// 获取加载状态
  bool get isLoading => _isLoading.value;

  /// 获取是否还有更多数据
  bool get hasMore => _hasMore.value;

  /// 获取当前页码
  int get page => _page.value;

  /// 构造函数,初始化时获取文章列表
  ArticleController() {
    fetchArticles();
  }

  /// 获取文章列表
  /// 无输入参数
  /// 无返回值
  Future<void> fetchArticles() async {
    try {
      /// 从 PocketBase 获取文章列表
      final records = await pbService.getArticles(_page.value, 10);
      _articles.addAll(records);
      _isLoading.value = false;
      _hasMore.value = records.isNotEmpty;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // 处理错误 (例如,显示 snackbar)
    }
  }

  /// 加载更多文章
  /// 无输入参数
  /// 无返回值
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
      // 处理错误 (例如,显示 snackbar)
    }
  }

  /// 单个文章的可观察对象
  final Rx<RecordModel?> _article = Rx<RecordModel?>(null);

  /// 获取单个文章
  RecordModel? get article => _article.value;

  /// 根据 ID 获取单个文章
  /// 输入参数:
  ///   id: 文章 ID (String)
  /// 无返回值
  Future<void> getArticleById(String id) async {
    _isLoading.value = true;
    _article.value = null; // 清除之前的文章数据
    update();
    try {
      final record = await pbService.getArticleById(id);
      _article.value = record;
      _isLoading.value = false;
      update();
    } catch (e) {
      _isLoading.value = false;
      update();
      // 处理错误 (例如,显示 snackbar)
    }
  }
}
