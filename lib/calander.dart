import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';





class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tree Planting Calendar')),
      body: Center(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2024, 12, 31),
          // Customize other properties as needed
          // For example: events, holidays, etc.
        ),
      ),
    );
  }
}