import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/plan_controller.dart';
import 'package:jieyan_app/widgets/interactive_calendar.dart';
import 'package:jieyan_app/widgets/stage_timeline.dart';
import 'package:jieyan_app/widgets/symptom_record_form.dart';

class PlanPage extends StatelessWidget {
  final PlanController controller = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒烟计划'),
      ),
      body: Obx(() {
        if (controller.planProgress.value == null) {
          return const Center(child: Text('尚未开始戒烟计划'));
        }

        return ListView(
          children: [
            const StageTimeline(),
            const InteractiveCalendar(),
            ListTile(
              title: const Text('开始日期'),
              subtitle:
                  Text(controller.planProgress.value!.startDate.toString()),
            ),
            ListTile(
              title: const Text('当前阶段'),
              subtitle: Text(controller.currentStage.value?.name ?? '无阶段'),
            ),
            ListTile(
              title: const Text('每日任务'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.dailyTasks
                    .map((task) => Text('- $task'))
                    .toList(),
              ),
            ),
            ListTile(
              title: const Text('每日打卡'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.dailyCheckIns.entries
                    .map((entry) =>
                        Text('${entry.key}: ${entry.value ? '已完成' : '未完成'}'))
                    .toList(),
              ),
            ),
            ListTile(
              title: const Text('症状记录'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.symptomRecords
                    .map((record) => Text(
                        '${record.dateTime}: ${record.symptom} - ${record.copingStrategy}'))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: controller.dailyCheckIn,
              child: const Text('每日打卡'),
            ),
            ElevatedButton(
              onPressed: () {
                // 打开记录症状的对话框
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('记录症状'),
                      content: SymptomRecordForm(),
                    );
                  },
                );
              },
              child: const Text('记录症状'),
            ),
          ],
        );
      }),
    );
  }
}
