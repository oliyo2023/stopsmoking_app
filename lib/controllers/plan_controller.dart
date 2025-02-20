import 'package:get/get.dart';
import '../providers/plan_provider.dart';
import '../models/plan_models.dart';

class PlanController extends GetxController {
  final PlanProvider planProvider = Get.find<PlanProvider>();

  final currentStage = Rxn<PlanStage>();
  final planProgress = Rxn<PlanProgress>();
  final dailyTasks = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    fetchPlanStages();
  }

  Future<void> fetchPlanStages() async {
    final stages = await planProvider.getPlanStages();
    if (stages.isNotEmpty) {
      currentStage.value = stages.first; // 默认设置第一个阶段
      dailyTasks.value = currentStage.value?.tasks ?? [];
    }
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
      planProgress.value!.dailyCheckIn[DateTime.now()] = true;
      planProgress.refresh(); // 触发 UI 更新
    }
  }

  void recordSymptom(String symptom, String copingStrategy) {
    final record = SymptomRecord(
      dateTime: DateTime.now(),
      symptom: symptom,
      copingStrategy: copingStrategy,
    );
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
