import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jieyan_app/models/checkin_model.dart';
import 'package:intl/intl.dart';

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

  Future<List<CheckinModel>> getCheckinRecords(
      String userId, DateTime startDate, DateTime endDate) async {
    final records = await _pb.collection('checkins').getList(
          filter:
              'user = "$userId" && date >= "${DateFormat('yyyy-MM-dd').format(startDate)}" && date <= "${DateFormat('yyyy-MM-dd').format(endDate)}"',
        );
    return records.items
        .map((item) => CheckinModel.fromJson(item.toJson()))
        .toList();
  }

  Future<RecordModel?> getUserInfo(String userId) async {
    try {
      final record = await _pb.collection('users').getOne(userId);
      return record;
    } catch (e) {
      return null;
    }
  }

  Future<RecordModel?> submitCheckin({
    required String date,
    required int smokeCount,
    required String reason,
  }) async {
    try {
      final record = await _pb.collection('checkins').create(body: {
        "date": date,
        "smokeCount": smokeCount,
        "reason": reason,
        "user": _pb.authStore.model.id,
      });
      return record;
    } catch (e) {
      return null;
    }
  }

  Future<List<RecordModel>> getRecommendedArticles(int limit) async {
    final records = await _pb.collection('posts').getList(
          perPage: limit,
          fields: 'id,title,summary',
        );
    return records.items;
  }

  // Future<List<RecordModel>> getArticles(int page, int perPage) async {
  //   final records = await _pb.collection('posts').getList(
  //       page: page,
  //       perPage: perPage,
  //       fields: 'id,title,created,updated',
  //       filter: 'cate="6193o6mlw3p6f4o"');
  //   return records.items;
  // }

  // Future<RecordModel?> getArticleById(String id) async {
  //   try {
  //     final record = await _pb.collection('posts').getOne(id);
  //     return record;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
