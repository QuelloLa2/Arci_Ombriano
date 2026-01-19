import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(children: [_calendarTable()]);
  }

  // Calendar Table
  Widget _calendarTable() {
    return TableCalendar(
      rowHeight: 80,
      locale: 'it_IT',
      availableCalendarFormats: {
        CalendarFormat.week: "Settimana",
        CalendarFormat.month: "Mese",
      },
      calendarBuilders: _builderCalendar(),
      focusedDay: today,
      firstDay: DateTime.utc(2026, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      onDaySelected: _onDaySelected,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(
          Icons.keyboard_arrow_left_outlined,
          color: Colors.black,
          size: 32,
        ),
        rightChevronIcon: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }

  CalendarBuilders _builderCalendar() {
    return CalendarBuilders(
      dowBuilder: (context, day) {
        final text = DateFormat.E('it_IT"').format(day);

        if (day.weekday == DateTime.sunday) {
          return Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return Center(child: Text(text.toUpperCase()));
      },
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
}
