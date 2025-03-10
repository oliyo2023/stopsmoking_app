import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/plan_controller.dart';
import 'package:jieyan_app/widgets/interactive_calendar.dart';
import 'package:jieyan_app/widgets/stage_timeline.dart';
import 'package:jieyan_app/widgets/symptom_record_form.dart';

// ignore: use_key_in_widget_constructors
class PlanPage extends StatelessWidget {
  // 获取 PlanController 的实例，使用 GetX 的 Get.put 进行依赖注入，确保整个应用只有一个实例
  final PlanController controller = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    // 返回一个 Scaffold，它提供了基本的 Material Design 布局结构，包括 AppBar 和 body
    return Scaffold(
      // AppBar 作为页面的顶部导航栏
      appBar: AppBar(
        title: const Text('戒烟计划'), // 标题为 "戒烟计划"
      ),
      // body 是页面的主要内容区域，使用 Obx 来响应式地构建 UI，当 controller 中的响应式变量改变时，会重新构建
      body: Obx(() {
        // 如果 smokingInfo 为 null，说明用户还没有填写吸烟信息，显示吸烟信息填写表单
        if (controller.smokingInfo.value == null) {
          return _buildSmokingInfoForm(); // 返回吸烟信息表单 Widget
        }

        // 如果 planProgress 为 null，说明用户已经填写了吸烟信息，但还没有开始戒烟计划，显示吸烟分析结果和开始计划按钮
        if (controller.planProgress.value == null) {
          return Column(
            children: [
              _buildSmokingAnalysis(), // 显示吸烟分析结果 Widget
              // 开始戒烟计划按钮
              ElevatedButton(
                onPressed: () => controller.startPlan(DateTime
                    .now()), // 点击后调用 controller 的 startPlan 方法，传入当前时间作为开始时间
                child: const Text('开始戒烟计划'), // 按钮文本为 "开始戒烟计划"
              ),
            ],
          );
        }

        // 如果 smokingInfo 和 planProgress 都不为 null，说明用户已经开始戒烟计划，显示计划进度页面
        return ListView(
          children: [
            const StageTimeline(), // 显示戒烟阶段时间线 Widget
            const InteractiveCalendar(), // 显示交互式日历 Widget
            // 使用 Card 替代 ListTile
            Card(
              child: ListTile(
                title: const Text('开始日期'), // 标题为 "开始日期"
                subtitle: Text(controller.planProgress.value!.startDate
                    .toString()), // 副标题显示计划开始日期
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('当前阶段'), // 标题为 "当前阶段"
                subtitle: Text(controller.currentStage.value?.name ??
                    '无阶段'), // 副标题显示当前阶段名称，如果为空则显示 "无阶段"
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('每日任务'), // 标题为 "每日任务"
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 子元素左对齐
                  // 将每日任务列表转换为 Text Widget 列表
                  children: controller.dailyTasks
                      .map((task) => Text('- $task')) // 使用 - 符号表示列表项
                      .toList(), // 转换为 List
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('每日打卡'), // 标题为 "每日打卡"
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 子元素左对齐
                  // 将每日打卡记录转换为 Text Widget 列表
                  children: controller.dailyCheckIns.entries
                      .map((entry) => Text(
                          '${entry.key}: ${entry.value ? '已完成' : '未完成'}')) // 显示日期和完成状态
                      .toList(), // 转换为 List
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('症状记录'), // 标题为 "症状记录"
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 子元素左对齐
                  // 将症状记录转换为 Text Widget 列表
                  children: controller.symptomRecords
                      .map((record) => Text(
                          '${record.dateTime}: ${record.symptom} - ${record.copingStrategy}')) // 显示记录时间和症状及应对策略
                      .toList(), // 转换为 List
                ),
              ),
            ),
            // 每日打卡按钮
            ElevatedButton(
              onPressed:
                  controller.dailyCheckIn, // 点击后调用 controller 的 dailyCheckIn 方法
              child: const Text('每日打卡'), // 按钮文本为 "每日打卡"
            ),
            // 记录症状按钮
            ElevatedButton(
              onPressed: () {
                // 打开记录症状的对话框
                showDialog(
                  context: context, // 上下文
                  // builder 用于构建对话框内容
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('记录症状'), // 对话框标题
                      content:
                          SymptomRecordForm(), // 对话框内容为 SymptomRecordForm Widget
                    );
                  },
                );
              },
              child: const Text('记录症状'), // 按钮文本为 "记录症状"
            ),
          ],
        );
      }),
    );
  }

  // 构建吸烟信息表单 Widget
  Widget _buildSmokingInfoForm() {
    // 初始化四个 TextEditingController 用于控制文本输入框
    final TextEditingController smokingAgeController =
        TextEditingController(); // 吸烟年限
    final TextEditingController dailyAmountController =
        TextEditingController(); // 每日吸烟量
    final TextEditingController brandController =
        TextEditingController(); // 香烟品牌
    final TextEditingController priceController =
        TextEditingController(); // 单包价格

    // 使用 StatefulBuilder 以便在表单提交后更新 UI
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(16.0), // 添加边距
        child: ListView(
          children: [
            // 标题
            const Text('请填写您的吸烟信息',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)), // 文本样式：粗体，字号20
            const SizedBox(height: 20), // 添加间隔
            // 调用 _buildTextField 方法构建文本输入框，输入类型为数字
            _buildTextField(smokingAgeController, '吸烟年限（年）',
                TextInputType.number), // 吸烟年限输入框
            _buildTextField(dailyAmountController, '每日吸烟量（支）',
                TextInputType.number), // 每日吸烟量输入框
            _buildTextField(
                brandController, '香烟品牌', TextInputType.text), // 香烟品牌输入框
            _buildTextField(
                priceController, '单包价格（元）', TextInputType.number), // 单包价格输入框
            const SizedBox(height: 20), // 添加间隔
            // 提交信息按钮
            ElevatedButton(
              onPressed: () {
                // 当用户点击提交信息时，将表单数据传递给 controller 的 collectSmokingInfo 方法
                controller.collectSmokingInfo(
                  smokingAge:
                      int.parse(smokingAgeController.text), // 吸烟年限，需要转换为 int
                  dailySmokingAmount:
                      int.parse(dailyAmountController.text), // 每日吸烟量，需要转换为 int
                  cigaretteBrand: brandController.text, // 香烟品牌
                  cigarettePrice:
                      double.parse(priceController.text), // 单包价格，需要转换为 double
                );
              },
              child: const Text('提交信息'), // 按钮文本为 "提交信息"
            ),
          ],
        ),
      );
    });
  }

  // 构建通用文本输入框
  // 参数: controller (文本输入框的控制器), labelText (文本输入框的标签文本), keyboardType (键盘类型)
  Widget _buildTextField(TextEditingController controller, String labelText,
      TextInputType keyboardType) {
    return TextField(
      controller: controller, // 绑定控制器
      decoration: InputDecoration(labelText: labelText), // 设置标签文本
      keyboardType: keyboardType, // 设置键盘类型
    );
  }

  // 构建吸烟分析结果 Widget
  Widget _buildSmokingAnalysis() {
    return Padding(
      padding: const EdgeInsets.all(16.0), // 添加边距
      child: ListView(
        children: [
          // 标题
          const Text('吸烟分析结果',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)), // 文本样式：粗体，字号20
          const SizedBox(height: 20), // 添加间隔
          // 经济影响标题
          const Text('经济影响',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)), // 文本样式：粗体，字号16
          // 构建经济影响列表
          ..._buildImpactList(controller.economicImpact, true), // 展开列表
          const Divider(), // 分割线
          // 健康影响标题
          const Text('健康影响',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)), // 文本样式：粗体，字号16
          // 构建健康影响列表
          ..._buildImpactList(controller.healthImpact, false), // 展开列表
        ],
      ),
    );
  }

  // 构建影响列表
  // 参数: impactMap (影响数据的 Map), isEconomic (是否是经济影响)
  List<Widget> _buildImpactList(
      Map<String, dynamic> impactMap, bool isEconomic) {
    // 将 Map 转换为 ListTile 列表
    return impactMap.entries
        .map((entry) => ListTile(
              title: Text(entry.key), // 标题为 key
              trailing: Text(isEconomic
                  ? '¥${entry.value.toStringAsFixed(2)}' // 如果是经济影响，则添加货币符号
                  : entry.value.toString()), // 否则直接显示值
            ))
        .toList(); // 转换为 List
  }
}
