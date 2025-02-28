import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/widgets/stage_timeline.dart';

class QuitPlanSection extends StatelessWidget {
  const QuitPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('戒烟计划',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const StageTimeline(),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/plan');
                },
                child: const Text('查看完整计划'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}