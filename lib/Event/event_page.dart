import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arci_ombriano/Event/event_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.listEvents});

  final List<Event> listEvents;

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
        Expanded(
          child: ListView.builder(
            itemCount: widget.listEvents.length,
            itemBuilder: (context, index) {
              final event = widget.listEvents[index];
              return Column(
                children: [
                  _isSameDate(index),
                  EventWidget(
                    nameEvent: event.nameEvent,
                    description: event.description,
                    time: event.timeEvent,
                    mapVolunteer: event.mapVolunteers,
                    primary: mainColor,
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
        style: GoogleFonts.poppins(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: -0.7,
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
      padding: EdgeInsets.only(left: 35),
      child: Text(
        dateString,
        style: GoogleFonts.poppins(
          fontSize: 32,
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
    return const SizedBox(height: 15);
  }
}
