import 'package:get/get.dart';
import 'package:jieyan_app/providers/plan_provider.dart';
import 'package:jieyan_app/models/plan_models.dart';

import '../models/smoking_info_model.dart';

class PlanController extends GetxController {
  final PlanProvider planProvider = Get.find<PlanProvider>();

  final currentStage = Rxn<PlanStage>();
  final planProgress = Rxn<PlanProgress>();
  final dailyTasks = RxList<String>();
  final dailyCheckIns = RxMap<DateTime, bool>(); // 记录每日打卡情况
  final symptomRecords = RxList<SymptomRecord>(); // 记录症状和应对策略

  final smokingInfo = Rxn<SmokingInfo>();

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
    if (currentStage.value != null && smokingInfo.value != null) {
      planProgress.value = PlanProgress(
        stage: currentStage.value!,
        startDate: startDate,
        dailyCheckIn: {},
        symptomRecords: [],
      );
      updateDailyTasks();
    }
  }

  void collectSmokingInfo({
    required int smokingAge,
    required int dailySmokingAmount,
    required String cigaretteBrand,
    required double cigarettePrice,
  }) {
    smokingInfo.value = SmokingInfo(
      smokingAge: smokingAge,
      dailySmokingAmount: dailySmokingAmount,
      cigaretteBrand: cigaretteBrand,
      cigarettePrice: cigarettePrice,
    );
    calculateEconomicImpact();
    calculateHealthImpact();
    predictQuittingBenefits();
  }

  final economicImpact = RxMap<String, double>();

  void calculateEconomicImpact() {
    if (smokingInfo.value != null) {
      // 计算经济影响
      double dailyCost = smokingInfo.value!.cigarettePrice /
          20 *
          smokingInfo.value!.dailySmokingAmount;
      double annualCost = dailyCost * 365;
      double totalCost = annualCost * smokingInfo.value!.smokingAge;

      // 存储经济影响数据到状态中
      economicImpact.value = {
        '日花费': dailyCost,
        '年花费': annualCost,
        '总花费': totalCost,
      };
    }
  }

  final healthImpact = RxMap<String, dynamic>();

  void calculateHealthImpact() {
    if (smokingInfo.value != null) {
      // 计算健康影响
      double nicotineIntake = smokingInfo.value!.dailySmokingAmount *
          0.8 *
          365 *
          smokingInfo.value!.smokingAge;

      // 存储健康影响数据到状态中
      healthImpact.value = {
        '总尼古丁摄入量': nicotineIntake,
        '肺部健康风险': '较高',
        '心血管疾病风险': '较高',
        '免疫系统影响': '中度受损',
      };
    }
  }

  final quittingBenefits = RxMap<String, dynamic>();

  void predictQuittingBenefits() {
    if (smokingInfo.value != null) {
      // 预测一年内的经济收益
      double dailyCost = smokingInfo.value!.cigarettePrice / 20 * smokingInfo.value!.dailySmokingAmount;
      double yearSaving = dailyCost * 365;

      // 预测一年内的健康收益
      // 根据世界卫生组织的研究，戒烟后的健康改善时间表
      Map<String, String> healthBenefits = {
        '20分钟': '血压和心率恢复正常',
        '12小时': '血液中的一氧化碳水平降至正常',
        '2周-3个月': '心脏病发作的风险开始下降，肺功能开始改善',
        '1-9个月': '咳嗽和呼吸短促的情况减少',
        '1年': '冠心病风险降低一半'
      };

      // 将预测结果存储到状态中
      quittingBenefits.value = {
        '年度节省': yearSaving,
        '健康收益': healthBenefits
      };
    }
  }

  void dailyCheckIn() {
    if (planProgress.value != null) {
      planProgress.value!.dailyCheckIn[DateTime.now()] = true;
      // planProvider.saveDailyCheckIn(DateTime.now()); // This method doesn't exist in PlanProvider
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

  SmokingInfo? getSmokingInfo() {
    return smokingInfo.value;
  }

  @override
  void onClose() {
    // 清理资源
    super.onClose();
  }
}
