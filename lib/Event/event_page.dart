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
    required this.onRefresh,
    required this.modifyEvent,
    required this.addEvent,
    required this.deleteEvent,
    required this.currentUserName,
  });

  final bool isAdmin;
  final List<Event> listEvents;
  final String currentUserName;

  final Future<void> Function() onRefresh;
  final Function(Event) modifyEvent;
  final Function(Event) addEvent;
  final Function(Event) deleteEvent;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late List<List<Event>> sortedList;

  @override
  void initState() {
    super.initState();
    sortedList = _sortEvents();
  }

  @override
  void didUpdateWidget(covariant EventPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listEvents != widget.listEvents) {
      setState(() {
        sortedList = _sortEvents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _newEvents,
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _titleEvent(
              Theme.of(context).colorScheme.primary,
              "Eventi prossimi",
            ),
          ),
          sortedList[0].isEmpty
              ? SliverToBoxAdapter(
                  child: Column(
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
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final event = sortedList[0][index];
                    return Column(
                      children: [
                        _isSameDate(index, sortedList[0]),
                        EventWidget(
                          key: ValueKey(event.id),
                          event: event,
                          index: index,
                          primary: Theme.of(context).colorScheme.primary,
                          modifyEvent: widget.modifyEvent,
                          deleteEvent: widget.deleteEvent,
                          isAdmin: widget.isAdmin,
                          currentUserName: widget.currentUserName,
                        ),
                      ],
                    );
                  }, childCount: sortedList[0].length),
                ),
          if (sortedList[1].isNotEmpty)
            SliverToBoxAdapter(child: _pastEventCard(sortedList[1])),
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
                          builder: (_) => InformationPage(event: event, currentUserName: widget.currentUserName),
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

  Future _newEvents() async {
    await widget.onRefresh();
    setState(() {
      sortedList = _sortEvents();
    });
  }

  // Sort and Divide eventlist in Newest e Oldest
  List<List<Event>> _sortEvents() {
    final sorted = List<Event>.from(widget.listEvents);
    sorted.sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    List<Event> newestEvents = [];
    List<Event> oldestEvents = [];
    DateTime now = DateTime.now();

    for (var event in sorted) {
      if (event.dateEvent.isAfter(now)) {
        newestEvents.add(event);
      } else {
        oldestEvents.add(event);
      }
    }

    return [newestEvents, oldestEvents];
  }
}
