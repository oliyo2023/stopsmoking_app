import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/config.dart';

class PocketBaseService {
  final PocketBase _pb = PocketBase(pocketBaseUrl);

  PocketBase get pb => _pb;

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
}
