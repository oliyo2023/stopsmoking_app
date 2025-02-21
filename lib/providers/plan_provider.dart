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

  Future<PlanProgress?> getPlanProgress() async {
    // 模拟从数据库或网络获取计划进度
    // 这里可以替换为实际的数据获取逻辑
    return null; // 或者返回一个默认值或从数据源获取的值
  }

  Future<List<SymptomRecord>> getSymptomRecords() async {
    // 模拟从数据库或网络获取症状记录
    // 实际应用中应替换为真实的逻辑
    return [
      SymptomRecord(
        dateTime: DateTime.now(),
        symptom: '头痛',
        copingStrategy: '休息片刻',
      ),
      // 添加更多模拟数据...
    ];
  }

  Future<void> saveDailyCheckIn(DateTime date) async {
    // 实现保存每日打卡记录的逻辑
    // 例如：将打卡记录保存到数据库或本地存储
  }
}
