import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/plan_controller.dart';
import 'package:jieyan_app/widgets/interactive_calendar.dart';
import 'package:jieyan_app/widgets/stage_timeline.dart';
import 'package:jieyan_app/widgets/symptom_record_form.dart';

// ignore: use_key_in_widget_constructors
class PlanPage extends StatelessWidget {
  final PlanController controller = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒烟计划'),
      ),
      body: Obx(() {
        if (controller.smokingInfo.value == null) {
          return _buildSmokingInfoForm();
        }

        if (controller.planProgress.value == null) {
          return Column(
            children: [
              _buildSmokingAnalysis(),
              ElevatedButton(
                onPressed: () => controller.startPlan(DateTime.now()),
                child: const Text('开始戒烟计划'),
              ),
            ],
          );
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

  Widget _buildSmokingInfoForm() {
    final TextEditingController smokingAgeController = TextEditingController();
    final TextEditingController dailyAmountController = TextEditingController();
    final TextEditingController brandController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    // 添加 dispose 逻辑以避免内存泄漏
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('请填写您的吸烟信息',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildTextField(
                smokingAgeController, '吸烟年限（年）', TextInputType.number),
            _buildTextField(
                dailyAmountController, '每日吸烟量（支）', TextInputType.number),
            _buildTextField(brandController, '香烟品牌', TextInputType.text),
            _buildTextField(priceController, '单包价格（元）', TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.collectSmokingInfo(
                  smokingAge: int.parse(smokingAgeController.text),
                  dailySmokingAmount: int.parse(dailyAmountController.text),
                  cigaretteBrand: brandController.text,
                  cigarettePrice: double.parse(priceController.text),
                );
              },
              child: const Text('提交信息'),
            ),
          ],
        ),
      );
    });
  }

// 新增方法：构建通用文本输入框
  Widget _buildTextField(TextEditingController controller, String labelText,
      TextInputType keyboardType) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
    );
  }

  Widget _buildSmokingAnalysis() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('吸烟分析结果',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('经济影响',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ..._buildImpactList(controller.economicImpact, true),
          const Divider(),
          const Text('健康影响',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ..._buildImpactList(controller.healthImpact, false),
        ],
      ),
    );
  }

// 新增方法：构建影响列表
  List<Widget> _buildImpactList(
      Map<String, dynamic> impactMap, bool isEconomic) {
    return impactMap.entries
        .map((entry) => ListTile(
              title: Text(entry.key),
              trailing: Text(isEconomic
                  ? '¥${entry.value.toStringAsFixed(2)}'
                  : entry.value.toString()),
            ))
        .toList();
  }
}
