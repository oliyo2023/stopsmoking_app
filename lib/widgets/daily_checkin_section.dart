import 'package:flutter/material.dart';
import 'package:jieyan_app/widgets/interactive_calendar.dart';

class DailyCheckinSection extends StatelessWidget {
  final Function onCheckin;

  const DailyCheckinSection({super.key, required this.onCheckin});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('每日打卡',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const InteractiveCalendar(),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () => onCheckin(),
                child: const Text('每日打卡'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
