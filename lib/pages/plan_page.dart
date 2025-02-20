import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/plan_controller.dart';
import '../widgets/stage_timeline.dart';
import '../widgets/interactive_calendar.dart';

class PlanPage extends StatelessWidget {
  final PlanController controller = Get.find<PlanController>();

  PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒烟计划 (Quit Smoking Plan)'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchPlanStages(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStageTimeline(),
              const SizedBox(height: 16),
              _buildCalendar(),
              const SizedBox(height: 16),
              _buildCurrentTasks(),
              const SizedBox(height: 16),
              _buildSymptomForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageTimeline() {
    return Obx(() {
      if (controller.currentStage.value == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return StageTimeline(
        stages: [controller.currentStage.value!],
        currentStage: controller.currentStage.value!,
      );
    });
  }

  Widget _buildCalendar() {
    return Obx(() {
      final progress = controller.planProgress.value;
      if (progress?.startDate == null) {
        return ElevatedButton(
          onPressed: () => controller.startPlan(DateTime.now()),
          child: const Text('开始戒烟计划 (Start Quit Plan)'),
        );
      }

      return InteractiveCalendar(
        startDate: progress!.startDate!,
        dailyCheckIn: progress.dailyCheckIn,
        onDaySelected: (_) => controller.dailyCheckIn(),
      );
    });
  }

  Widget _buildCurrentTasks() {
    return Obx(() {
      final tasks = controller.dailyTasks;
      if (tasks.isEmpty) {
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('暂无任务 (No tasks available)'),
          ),
        );
      }

      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '当前任务 (Current Tasks)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...tasks.map((task) => _buildTaskItem(task)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTaskItem(String task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline),
          const SizedBox(width: 8),
          Expanded(child: Text(task)),
        ],
      ),
    );
  }

  Widget _buildSymptomForm() {
    return const SizedBox.shrink();
//       return SymptomRecordForm(
//         onSubmit: (symptom, strategy) =>
// (symptom, strategy) => controller.recordSymptom(symptom, strategy),
//       );
  }
}
