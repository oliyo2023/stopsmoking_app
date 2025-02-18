import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseService extends GetxService {
  late final PocketBase _pb;

  PocketBase get pb => _pb;

  static PocketBaseService get to => Get.find<PocketBaseService>();

  Future<PocketBaseService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );
    _pb = PocketBase(pocketBaseUrl, authStore: store);
    return this;
  }

  /// 提交每日打卡记录
  Future<void> submitCheckin({
    required String date,
    required int smokeCount,
    String? reason,
  }) async {
    await _pb.collection('checkins').create(body: {
      'date': date,
      'smoke_count': smokeCount,
      'reason': reason,
    });
  }

  Future<List<RecordModel>> getArticles(int page, int perPage) async {
    final records = await _pb.collection('posts').getList(
        page: page,
        perPage: perPage,
        fields: 'id,title,created,updated',
        filter: 'cate="6193o6mlw3p6f4o"');
    return records.items;
  }

  Future<RecordModel?> getArticleById(String id) async {
    try {
      final record = await _pb.collection('posts').getOne(id);
      return record;
    } catch (e) {
      return null;
    }
  }
}
