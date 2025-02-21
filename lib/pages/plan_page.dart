import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/plan_controller.dart';

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
                    return AlertDialog(
                      title: const Text('记录症状'),
                      content: SymptomForm(controller: controller),
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

class SymptomForm extends StatelessWidget {
  final PlanController controller;

  SymptomForm({super.key, required this.controller});

  final TextEditingController _symptomController = TextEditingController();
  final TextEditingController _copingStrategyController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _symptomController,
            decoration: const InputDecoration(
              labelText: '症状',
            ),
          ),
          TextFormField(
            controller: _copingStrategyController,
            decoration: const InputDecoration(
              labelText: '应对策略',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.recordSymptom(
                _symptomController.text,
                _copingStrategyController.text,
              );
              Navigator.of(context).pop();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}
