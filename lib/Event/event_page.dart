import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Event/event_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    super.key,
    required this.listEvents,
    required this.isAdmin,
    required this.modifyEvent,
    required this.addEvent,
    required this.deleteEvent,
  });

  final List<Event> listEvents;
  final bool isAdmin;

  final Function(int, Event) modifyEvent;
  final Function(Event) addEvent;
  final Function(Event) deleteEvent;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    List<List<Event>> sortedList = _sortEvents(widget.listEvents);
    return Column(
      children: [
        _titleEvent(Theme.of(context).colorScheme.primary, "Eventi prossimi"),

        sortedList[0].isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Non ci sono eventi",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : _eventListTiles(sortedList[0]),

        _titleEvent(Theme.of(context).colorScheme.primary, "Eventi Passati"),
        sortedList[1].isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Non ci sono eventi",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : _eventListTiles(sortedList[1]),
      ],
    );
  }

  // Title
  Widget _titleEvent(Color color, String data) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15, left: 20),
      child: Text(
        data,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: -0.6,
        ),
      ),
    );
  }

  // Title date
  Widget _dateTitle(DateTime date, Color color) {
    String dateString =
        DateFormat("- EEEEE", 'it_IT').format(date) +
        DateFormat("EEEE dd/MM/yy", 'it_IT').format(date).substring(1);

    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      child: Text(
        dateString,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: -0.7,
        ),
      ),
    );
  }

  Widget _eventListTiles(List<Event> eventlist) {
    return Expanded(
      child: ListView.builder(
        itemCount: eventlist.length,
        itemBuilder: (context, index) {
          final event = eventlist[index];
          return Column(
            children: [
              _isSameDate(index, eventlist),
              EventWidget(
                key: ValueKey(event.id),
                event: event,
                index: index,
                primary: Theme.of(context).colorScheme.primary,
                modifyEvent: widget.modifyEvent,
                deleteEvent: widget.deleteEvent,
                isAdmin: widget.isAdmin,
              ),
            ],
          );
        },
      ),
    );
  }

  // Controll Same Day/Month
  Widget _isSameDate(int index, List<Event> listEvents) {
    Color dateColor = Color(0xFF1A0704);

    bool controll =
        index == 0 ||
        !DateUtils.isSameDay(
          listEvents[index].dateEvent,
          listEvents[index - 1].dateEvent,
        );

    if (controll) {
      return _dateTitle(listEvents[index].dateEvent, dateColor);
    }
    return const SizedBox(height: 7.5);
  }

  // Sort and Divide eventlist in Newest e Oldest
  List<List<Event>> _sortEvents(List<Event> events) {
    List<Event> newestEvents = [];
    List<Event> oldestEvents = [];
    DateTime now = DateTime.now();

    for (var event in events) {
      if (event.dateEvent.isAfter(now)) {
        newestEvents.add(event);
      } else {
        oldestEvents.add(event);
      }
    }

    return [newestEvents, oldestEvents];
  }
}
