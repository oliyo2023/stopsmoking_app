import 'package:flutter/material.dart';
import 'package:jieyan_app/models/plan_models.dart';

class StageTimeline extends StatefulWidget {
  // ignore: use_super_parameters
  const StageTimeline({Key? key}) : super(key: key);

  @override
  State<StageTimeline> createState() => _StageTimelineState();
}

class _StageTimelineState extends State<StageTimeline> {
  final List<PlanStage> _planStages = [
    PlanStage(
      name: '准备阶段',
      durationDays: 7,
      tasks: ['了解戒烟的好处', '设定戒烟目标', '制定戒烟计划'],
    ),
    PlanStage(
      name: '行动阶段',
      durationDays: 30,
      tasks: ['开始戒烟', '应对戒断反应', '寻求支持'],
    ),
    PlanStage(
      name: '巩固阶段',
      durationDays: 90,
      tasks: ['巩固戒烟成果', '预防复吸', '享受健康生活'],
    ),
  ];

  final int _currentStageIndex = 1; // 假设当前处于行动阶段

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _planStages.length,
      itemBuilder: (context, index) {
        final stage = _planStages[index];
        final isCurrentStage = index == _currentStageIndex;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 圆点和连接线
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrentStage
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryColor, // 当前阶段使用强调色
                  ),
                  child: const Center(
                    child: Icon(Icons.circle, color: Colors.white, size: 12),
                  ),
                ),
                if (index < _planStages.length - 1)
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // 阶段信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isCurrentStage
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.black), // 当前阶段使用强调色
                  ),
                  const SizedBox(height: 4),
                  Text('持续 ${stage.durationDays} 天',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stage.tasks
                        .map((task) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.task_alt,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(task,
                                      style: TextStyle(
                                          color: Colors.grey.shade700)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
