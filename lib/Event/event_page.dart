import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Event/event_widget.dart';
import 'package:arci_ombriano/Event/info_page.dart';

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

  final Function(Event) modifyEvent;
  final Function(Event) addEvent;
  final Function(Event) deleteEvent;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    List<List<Event>> sortedList = _sortEvents(widget.listEvents);
    return SingleChildScrollView(
      child: Column(
        children: [
          _titleEvent(Theme.of(context).colorScheme.primary, "Eventi prossimi"),

          sortedList[0].isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Non ci sono eventi",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                )
              : Column(children: [_eventListTiles(sortedList[0])]),
          sortedList[1].isEmpty ? SizedBox() : _pastEventCard(sortedList[1]),
        ],
      ),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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

  Widget _pastEventCard(List<Event> listEvents) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white, width: 0),
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          tilePadding: EdgeInsets.symmetric(horizontal: 6),
          shape: LinearBorder.none,
          collapsedShape: LinearBorder.none,
          title: Text(
            "Eventi Passati",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listEvents.length,
              itemBuilder: (context, index) {
                final event = listEvents[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.7,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    //Name Event
                    leading: Text(
                      event.nameEvent,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //Date Event
                    title: Text(
                      "- ${DateFormat("dd/MM/yyyy").format(event.timeEvent)}",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Icona
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 32,
                    ),
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
              },
            ),
          ],
        ),
      ),
    );
  }

  // Sort and Divide eventlist in Newest e Oldest
  List<List<Event>> _sortEvents(List<Event> events) {
    events.sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

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
