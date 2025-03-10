import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxInt smokingYears = 0.obs;
  final RxInt cigarettesPerDay = 0.obs;
  final RxDouble pricePerPack = 0.0.obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    } else {
      // 完成所有步骤后的操作，例如计算结果或导航到下一个页面
      calculateResults();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void calculateResults() {
    // 计算每年花费
    double yearlyExpense =
        cigarettesPerDay.value * pricePerPack.value / 20 * 365;

    // 计算总花费 (烟龄 * 年花费)
    double totalExpense = smokingYears.value * yearlyExpense;

    // 计算消费对比 (举例)
    final purchaseComparisons = [
      {
        'item': 'iPhone 14 Pro',
        'price': 8999,
        'count': (totalExpense / 8999).floor()
      },
      {'item': '电影票', 'price': 50, 'count': (totalExpense / 50).floor()},
      {'item': '家庭旅行', 'price': 5000, 'count': (totalExpense / 5000).floor()},
    ];

    // 健康影响列表
    final healthImpacts = [
      '每支烟减少寿命约11分钟',
      '一包烟含有超过4000种化学物质，其中至少69种已知会导致癌症',
      '吸烟会增加患肺癌、心脏病、中风和呼吸系统疾病的风险',
      '吸烟会导致牙齿变黄、皮肤早衰',
      '二手烟对家人和周围人群健康造成极大危害'
    ];

    // 计算吸烟者的总计香烟数量
    int totalCigarettes = smokingYears.value * 365 * cigarettesPerDay.value;

    // 计算减少的寿命 (每支烟约11分钟)
    int lifeReductionMinutes = totalCigarettes * 11;
    int lifeReductionDays = lifeReductionMinutes ~/ (60 * 24);

    // 显示结果对话框
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '吸烟成本分析',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                // 金钱花费
                const Text('金钱花费',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  '¥${totalExpense.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                    '您吸烟${smokingYears.value}年，每天吸${cigarettesPerDay.value}支烟'),
                Text('每包烟价格：¥${pricePerPack.value.toStringAsFixed(1)}'),
                Text('每年花费：¥${yearlyExpense.toStringAsFixed(2)}'),

                const SizedBox(height: 16),
                // 购买对比
                const Divider(),
                const Text('您的烟钱可以购买',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  children: purchaseComparisons
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ((item['count'] as num?) ?? 0) > 0
                                ? Text(
                                    '${item['item']}: ${item['count']}台/张/次 (¥${item['price']})')
                                : const SizedBox.shrink(),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 16),
                // 健康影响
                const Divider(),
                const Text('健康影响',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('您已经吸了约$totalCigarettes支烟'),
                Text('减少的寿命约$lifeReductionDays天'),
                const SizedBox(height: 8),
                ...healthImpacts.map((impact) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(child: Text(impact)),
                        ],
                      ),
                    )),

                const SizedBox(height: 20),
                const Text(
                  '现在戒烟，您将节省金钱并改善健康！',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),
                // 按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('关闭'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.toNamed('/plan');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('开始戒烟'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('戒烟助手'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCurrentStep(),
              const SizedBox(height: 40),
              _buildNavigationButtons(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCurrentStep() {
    switch (controller.currentStep.value) {
      case 0:
        return _buildSmokingYearsStep();
      case 1:
        return _buildCigarettesPerDayStep();
      case 2:
        return _buildPricePerPackStep();
      default:
        return Container();
    }
  }

  Widget _buildSmokingYearsStep() {
    return Column(
      children: [
        const Text(
          '您有多长时间的烟龄？',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Slider(
          value: controller.smokingYears.value.toDouble(),
          min: 0,
          max: 50,
          divisions: 50,
          label: '${controller.smokingYears.value} 年',
          onChanged: (value) {
            controller.smokingYears.value = value.round();
          },
        ),
        Text(
          '${controller.smokingYears.value} 年',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildCigarettesPerDayStep() {
    return Column(
      children: [
        const Text(
          '您每天吸多少只烟？',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Slider(
          value: controller.cigarettesPerDay.value.toDouble(),
          min: 0,
          max: 60,
          divisions: 60,
          label: '${controller.cigarettesPerDay.value} 只',
          onChanged: (value) {
            controller.cigarettesPerDay.value = value.round();
          },
        ),
        Text(
          '${controller.cigarettesPerDay.value} 只',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildPricePerPackStep() {
    return Column(
      children: [
        const Text(
          '每包烟的价格是多少？',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Slider(
          value: controller.pricePerPack.value,
          min: 0,
          max: 100,
          divisions: 100,
          label: '¥${controller.pricePerPack.value.toStringAsFixed(1)}',
          onChanged: (value) {
            controller.pricePerPack.value =
                double.parse(value.toStringAsFixed(1));
          },
        ),
        Text(
          '¥${controller.pricePerPack.value.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (controller.currentStep.value > 0)
          ElevatedButton(
            onPressed: controller.previousStep,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('上一步'),
          ),
        ElevatedButton(
          onPressed: controller.nextStep,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: Colors.green,
          ),
          child: Text(controller.currentStep.value < 2 ? '下一步' : '完成'),
        ),
      ],
    );
  }
}
