import 'package:jieyan_app/models/plan_models.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class PlanProvider {
  final PocketBaseService pocketBaseService;

  PlanProvider({required this.pocketBaseService});

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
}
