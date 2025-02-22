import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:jieyan_app/controllers/interactive_calendar_controller.dart';

class InteractiveCalendar extends StatelessWidget {
  const InteractiveCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InteractiveCalendarController>(
      init: InteractiveCalendarController(),
      builder: (controller) {
        return Column(
          children: [
            TableCalendar(
              focusedDay: controller.focusedDay,
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDay = selectedDay;
                controller.focusedDay =
                    focusedDay; // update `focusedDay` here as well
                controller.update();
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (controller.checkinRecords.any((record) =>
                      isSameDay(DateTime.parse(record.date), day))) {
                    return Positioned(
                      bottom: 1,
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  }
                  return null;
                },
              ),
              onPageChanged: (focusedDay) {
                controller.focusedDay = focusedDay;
                controller.selectedDay = focusedDay;
                controller.fetchCheckinData();
              },
            ),
          ],
        );
      },
    );
  }
}
