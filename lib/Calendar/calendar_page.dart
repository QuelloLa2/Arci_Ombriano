import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Event/info_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.listEvents, required this.currentUserName});

  final List<Event> listEvents;
  final String currentUserName;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  List<Event> selectedEvent = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: _calendarTable(),
          ),
        ),
        const SizedBox(height: 12),
        _listEventView(),
      ],
    );
  }

  Widget _calendarTable() {
    return TableCalendar(
      rowHeight: 52,
      daysOfWeekHeight: 32,
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

  CalendarBuilders _builderCalendar() {
    return CalendarBuilders(
      dowBuilder: (context, day) {
        final text = DateFormat.E('it_IT').format(day);

        if (day.weekday == DateTime.sunday) {
          return Center(
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFFC74E43),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          );
        }

        return Center(
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
      selectedEvent = _createListEvents(selectedDay);
    });
  }

  HeaderStyle _headerStyle() {
    return HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      leftChevronIcon: const Icon(
        Icons.keyboard_arrow_left_outlined,
        color: Color(0xFFC74E43),
        size: 28,
      ),
      rightChevronIcon: const Icon(
        Icons.keyboard_arrow_right_outlined,
        color: Color(0xFFC74E43),
        size: 28,
      ),
      titleTextFormatter: (date, locale) =>
          DateFormat("MMM", 'it_IT').format(date).toUpperCase()[0] +
          DateFormat("MMMM ", 'it_IT').format(date).substring(1) +
          DateFormat.y(locale).format(date),
    );
  }

  CalendarStyle _calendarStyle() {
    Color mainColor = Theme.of(context).colorScheme.primary;

    return CalendarStyle(
      todayDecoration: BoxDecoration(
        color: mainColor.withAlpha(40),
        shape: BoxShape.circle,
      ),
      todayTextStyle: const TextStyle(
        color: Color(0xFFC74E43),
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
      selectedDecoration: BoxDecoration(
        color: mainColor,
        shape: BoxShape.circle,
      ),
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
      weekendTextStyle: const TextStyle(
        color: Color(0xFFC74E43),
        fontSize: 15,
      ),
      defaultTextStyle: const TextStyle(fontSize: 15),
      markersMaxCount: 3,
      markerDecoration: BoxDecoration(
        color: mainColor,
        shape: BoxShape.circle,
      ),
      markerSize: 5,
    );
  }

  List<Event> _createListEvents(DateTime day) {
    return widget.listEvents.where((event) {
      return isSameDay(event.dateEvent, day);
    }).toList();
  }

  Expanded _listEventView() {
    return Expanded(
      child: selectedEvent.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Nessun evento",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: selectedEvent.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final event = selectedEvent[index];
                return _eventTile(event);
              },
            ),
    );
  }

  Widget _eventTile(Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        title: Text(
          event.nameEvent,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          DateFormat("HH:mm").format(event.timeEvent),
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 24,
          color: Colors.grey.shade600,
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => InformationPage(event: event, currentUserName: widget.currentUserName),
            ),
          );
        },
      ),
    );
  }
}
