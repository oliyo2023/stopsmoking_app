import 'package:jieyan_app/models/plan_models.dart';
import 'package:jieyan_app/models/smoking_info_model.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:logging/logging.dart';

class PlanProvider {
  final PocketBaseService pocketBaseService;
  final _logger = Logger('PlanProvider');

  PlanProvider({required this.pocketBaseService});

  Future<void> saveSmokingInfo(SmokingInfo info) async {
    // 保存吸烟信息到 PocketBase
    await pocketBaseService.pb.collection('smoking_info').create(
      body: {
        'smokingAge': info.smokingAge,
        'dailySmokingAmount': info.dailySmokingAmount,
        'cigaretteBrand': info.cigaretteBrand,
        'cigarettePrice': info.cigarettePrice,
      },
    );
  }

  Future<SmokingInfo?> getSmokingInfo() async {
    try {
      // 从 PocketBase 获取最新的吸烟信息
      final records = await pocketBaseService.pb
          .collection('smoking_info')
          .getList(sort: '-created', perPage: 1);

      if (records.items.isEmpty) {
        return null;
      }

      final record = records.items.first;
      return SmokingInfo(
        smokingAge: record.data['smokingAge'],
        dailySmokingAmount: record.data['dailySmokingAmount'],
        cigaretteBrand: record.data['cigaretteBrand'],
        cigarettePrice: record.data['cigarettePrice'],
      );
    } catch (e) {
      _logger.warning('获取吸烟信息失败', e);
      return null;
    }
  }

  Future<List<PlanStage>> getPlanStages() async {
    // Fetch plan stages from PocketBase
    // Replace with actual PocketBase collection name and logic
    final records =
        await pocketBaseService.pb.collection('plan_stages').getList(
              sort: '-created',
            );

    return records.items.map((record) {
      return PlanStage(
        name: record.data['name'],
        durationDays: record.data['durationDays'],
        tasks: List<String>.from(record.data['tasks']),
      );
    }).toList();
  }

  Future<void> saveSymptomRecord(SymptomRecord record) async {
    // Save symptom record to PocketBase
    // Replace with actual PocketBase collection name and logic
    await pocketBaseService.pb.collection('symptom_records').create(
      body: {
        'dateTime': record.dateTime.toIso8601String(),
        'symptom': record.symptom,
        'copingStrategy': record.copingStrategy,
      },
    );
  }

  void saveDailyCheckIn(DateTime dateTime) {}
}
