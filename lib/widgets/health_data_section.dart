import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/theme/app_theme.dart';

class HealthDataModel {
  final String name;
  final double value;
  final String unit;
  final String trend;

  HealthDataModel({
    required this.name,
    required this.value,
    required this.unit,
    required this.trend,
  });
}

class HealthDataSection extends StatelessWidget {
  final List<HealthDataModel> healthData;

  const HealthDataSection({super.key, required this.healthData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('健康数据',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: healthData
                  .map((data) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.name,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${data.value} ${data.unit}',
                                style: const TextStyle(color: AppColors.textSecondary)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/progress');
                },
                child: const Text('查看更多'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}