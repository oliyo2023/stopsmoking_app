import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

/// 文章数据提供者,负责所有与文章相关的数据操作
class ArticleProvider extends GetxController {
  /// PocketBase 服务实例
  final PocketBaseService pbService = Get.find<PocketBaseService>();



  /// 获取文章列表
  /// 输入参数:
  ///   page: 页码 (int)
  ///   pageSize: 每页数量 (int)
  /// 返回值: List<RecordModel>
  Future<List<RecordModel>> getArticles(int page, int pageSize) async {
    final records = await pbService.pb.collection('posts').getList(
        page: page,
        perPage: pageSize,
        fields: 'id,title,created,updated',
        filter: 'cate="6193o6mlw3p6f4o"');
    return records.items;
  }

  /// 根据 ID 获取单个文章
  /// 输入参数:
  ///   id: 文章 ID (String)
  /// 返回值: RecordModel
  Future<RecordModel?> getArticleById(String id) async {
    try {
      final record = await pbService.pb.collection('posts').getOne(id);
      return record;
    } catch (e) {
      return null;
    }
  }
}
