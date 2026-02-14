import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Event/info_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.listEvents});

  final List<Event> listEvents;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  List<Event> selectedEvent = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_calendarTable(), SizedBox(height: 15), _listEventView()],
    );
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
      headerStyle: _headerStyle(),
      calendarStyle: _calendarStyle(),
      eventLoader: _createListEvents,
    );
  }

  // Builder
  CalendarBuilders _builderCalendar() {
    return CalendarBuilders(
      dowBuilder: (context, day) {
        final text = DateFormat.E('it_IT').format(day);

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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
      selectedEvent = _createListEvents(selectedDay);
    });
  }

  //Header Style
  HeaderStyle _headerStyle() {
    return HeaderStyle(
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
      titleTextFormatter: (date, locale) =>
          DateFormat("MMM", 'it_IT').format(date).toUpperCase()[0] +
          DateFormat("MMMM ", 'it_IT').format(date).substring(1) +
          DateFormat.y(locale).format(date),
    );
  }

  //Calendar Style
  CalendarStyle _calendarStyle() {
    Color mainColor = Theme.of(context).colorScheme.primary;

    return CalendarStyle(
      todayDecoration: BoxDecoration(
        color: mainColor.withAlpha(128),
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: mainColor,
        shape: BoxShape.circle,
      ),
      weekendTextStyle: TextStyle(color: mainColor, fontSize: 18),
      defaultTextStyle: TextStyle(fontSize: 18),
    );
  }

  //Setup map for the events in calendar
  List<Event> _createListEvents(DateTime day) {
    return widget.listEvents.where((event) {
      return isSameDay(event.dateEvent, day);
    }).toList();
  }

  // Expanded list for events day
  Expanded _listEventView() {
    return Expanded(
      child: ListView.builder(
        itemCount: selectedEvent.length,
        itemBuilder: (context, index) {
          final event = selectedEvent[index];
          return Column(children: [_eventTile(event)]);
        },
      ),
    );
  }

  Widget _eventTile(Event event) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2.5,
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Text(
          event.nameEvent,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        title: Text(
          "- ${DateFormat("HH:mm").format(event.timeEvent)}",
          style: TextStyle(
            fontSize: 18,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right_rounded, size: 32),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => InformationPage(
                titleEvent: event.nameEvent,
                descEvent: event.description,
                mapVolunteers: event.mapVolunteers,
              ),
            ),
          );
        },
      ),
    );
  }
}
