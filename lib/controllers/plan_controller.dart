import 'package:get/get.dart';
import '../providers/plan_provider.dart';
import '../models/plan_models.dart';

class PlanController extends GetxController {
  final PlanProvider planProvider = Get.find<PlanProvider>();

  final currentStage = Rxn<PlanStage>();
  final planProgress = Rxn<PlanProgress>();
  final dailyTasks = RxList<String>();
  final dailyCheckIns = RxMap<DateTime, bool>(); // 记录每日打卡情况
  final symptomRecords = RxList<SymptomRecord>(); // 记录症状和应对策略

  @override
  void onInit() {
    super.onInit();
    fetchPlanStages();
    fetchPlanProgress();
    fetchSymptomRecords();
  }

  Future<void> fetchPlanStages() async {
    final stages = await planProvider.getPlanStages();
    if (stages.isNotEmpty) {
      currentStage.value = stages.first; // 默认设置第一个阶段
      dailyTasks.value = currentStage.value?.tasks ?? [];
    }
  }

  Future<void> fetchPlanProgress() async {
    final progress = await planProvider.getPlanProgress();
    planProgress.value = progress;
  }

  Future<void> fetchSymptomRecords() async {
    final records = await planProvider.getSymptomRecords();
    symptomRecords.value = records;
  }

  void startPlan(DateTime startDate) {
    planProgress.value = PlanProgress(
      startDate: startDate,
      currentStage: currentStage.value,
    );
    updateDailyTasks();
  }

  void dailyCheckIn() {
    if (planProgress.value != null) {
      dailyCheckIns[DateTime.now()] = true;
      planProgress.value!.dailyCheckIn[DateTime.now()] = true;
      planProvider.saveDailyCheckIn(DateTime.now());
      planProgress.refresh(); // 触发 UI 更新
    }
  }

  void recordSymptom(String symptom, String copingStrategy) {
    final record = SymptomRecord(
      dateTime: DateTime.now(),
      symptom: symptom,
      copingStrategy: copingStrategy,
    );
    symptomRecords.add(record);
    planProvider.saveSymptomRecord(record);
    planProgress.value?.symptomRecords.add(record);
    planProgress.refresh(); // 触发 UI 更新
  }

  void updateDailyTasks() {
    dailyTasks.value = currentStage.value?.tasks ?? [];
  }

  @override
  void onClose() {
    // 清理资源
    super.onClose();
  }
}
