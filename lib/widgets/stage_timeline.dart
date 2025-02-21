import 'package:flutter/material.dart';
import '../models/plan_models.dart';

class StageTimeline extends StatelessWidget {
  final List<PlanStage> stages;
  final PlanStage currentStage;

  const StageTimeline({
    super.key,
    required this.stages,
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '戒烟阶段 (Quit Smoking Stages)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stages.length,
                itemBuilder: (context, index) {
                  final stage = stages[index];
                  final isCurrentStage = stage == currentStage;
                  final isCompleted = stages.indexOf(currentStage) > index;

                  return Row(
                    children: [
                      _buildStageItem(stage, isCurrentStage, isCompleted),
                      if (index < stages.length - 1)
                        Container(
                          width: 30,
                          height: 2,
                          color: isCompleted
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageItem(PlanStage stage, bool isCurrent, bool isCompleted) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrent
                  ? Colors.blue
                  : isCompleted
                      ? Colors.green
                      : Colors.grey[300],
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.circle,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stage.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCurrent ? Colors.blue : Colors.black87,
            ),
          ),
          Text(
            '${stage.durationDays} 天',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
