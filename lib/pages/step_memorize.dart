import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StepMemorize extends StatefulWidget {
  const StepMemorize({super.key});

  @override
  State<StepMemorize> createState() => StepMemorizeState();
}

class StepMemorizeState extends State<StepMemorize> {
  final kToday = DateTime.now();

  DateTime focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.home_rounded,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  hoverColor: Theme.of(context).colorScheme.onSurface,
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
              ],
            ),
            TableCalendar(
              firstDay: DateTime(kToday.year, kToday.month - 3, kToday.day),
              lastDay: DateTime(kToday.year, kToday.month + 3, kToday.day),
              focusedDay: focusedDay,
              calendarFormat: calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
