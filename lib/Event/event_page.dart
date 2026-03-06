//TODO: differenziare prossime / vecchie rispetto al giorno attuale

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
  final Function(int, Event) modifyEvent;
  final Function(Event) addEvent;
  final Function(Event) deleteEvent;
  final bool isAdmin;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        _titleEvent(mainColor),

        widget.listEvents.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Non ci sono eventi",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: widget.listEvents.length,
                  itemBuilder: (context, index) {
                    final event = widget.listEvents[index];
                    return Column(
                      children: [
                        _isSameDate(index),
                        EventWidget(
                          event: event,
                          index: index,
                          primary: mainColor,
                          modifyEvent: widget.modifyEvent,
                          deleteEvent: widget.deleteEvent,
                          isAdmin: widget.isAdmin,
                        ),
                      ],
                    );
                  },
                ),
              ),
      ],
    );
  }

  // Title
  Widget _titleEvent(Color color) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15, left: 20),
      child: Text(
        "Prossimi Eventi",
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

  // Controll Same Day/Month
  Widget _isSameDate(int index) {
    Color dateColor = Color(0xFF1A0704);

    if (index == 0 ||
        !DateUtils.isSameDay(
          widget.listEvents[index].dateEvent,
          widget.listEvents[index - 1].dateEvent,
        )) {
      return _dateTitle(widget.listEvents[index].dateEvent, dateColor);
    }
    return const SizedBox(height: 7.5);
  }
}
