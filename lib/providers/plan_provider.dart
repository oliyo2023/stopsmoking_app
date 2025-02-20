import 'package:get/get.dart';
import '../services/pocketbase_service.dart';
import '../models/plan_models.dart';

class PlanProvider extends GetxService {
  final PocketBaseService pbService = Get.find<PocketBaseService>();

  Future<List<PlanStage>> getPlanStages() async {
    // TODO: 从 PocketBase 获取计划阶段配置
    // 示例数据，需要替换为从 PocketBase 获取
    return [
      PlanStage(
        name: '准备期',
        durationDays: 7,
        tasks: [
          '评估吸烟习惯和诱因',
          '设定明确的戒烟目标',
          '制定初步的应对策略',
        ],
      ),
      PlanStage(
        name: '戒断期',
        durationDays: 30,
        tasks: [
          '完全停止吸烟',
          '积极应对戒断症状',
          '寻求家人朋友支持',
        ],
      ),
      PlanStage(
        name: '巩固期',
        durationDays: 90,
        tasks: [
          '巩固戒烟成果',
          '避免复吸',
          '保持健康生活方式',
        ],
      ),
    ];
  }

  Future<void> saveSymptomRecord(SymptomRecord record) async {
    // TODO: 将症状记录保存到 PocketBase
    print('保存症状记录: ${record.symptom}'); // 示例，需要替换为 PocketBase 存储
  }
}
