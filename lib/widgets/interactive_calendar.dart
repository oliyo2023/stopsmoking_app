import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class InteractiveCalendar extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, bool> dailyCheckIn;
  final Function(DateTime) onDaySelected;

  const InteractiveCalendar({
    super.key,
    required this.startDate,
    required this.dailyCheckIn,
    required this.onDaySelected,
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
              '打卡日历 (Check-in Calendar)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TableCalendar(
              firstDay: startDate,
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                return dailyCheckIn[day] == true ? [true] : [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                onDaySelected(selectedDay);
              },
            ),
          ],
        ),
      ),
    );
  }
}
