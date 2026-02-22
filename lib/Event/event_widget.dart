import 'package:arci_ombriano/Event/info_page.dart';
import 'package:arci_ombriano/Admin/mod_event.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    required this.index,
    required this.event,
    required this.primary,
    required this.modifyEvent,
  });

  final int index;
  final Function(int, Event) modifyEvent;
  final Event event;
  final Color primary;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  late String nameEvent;
  late String description;
  late DateTime time;
  late Map<String, Map<String, int>> mapVolunteers;

  late Map<String, bool> mapIsSelected = {};

  @override
  void initState() {
    nameEvent = widget.event.nameEvent;
    description = widget.event.description;
    time = widget.event.timeEvent;
    mapVolunteers = widget.event.mapVolunteers;

    super.initState();
    mapIsSelected = {for (final key in mapVolunteers.keys) key: false};
  }

  @override
  Widget build(BuildContext context) {
    String timeString = DateFormat("HH:mm").format(time);

    return InkWell(
      enableFeedback: false,
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => InformationPage(
              titleEvent: nameEvent,
              descEvent: description,
              mapVolunteers: mapVolunteers,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 3),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border.all(color: const Color(0x68232120), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Title Event
            Row(
              children: [
                Text(
                  nameEvent,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Expanded(child: SizedBox()),

                //TODO: logica utente / admin del pulsante
                _editButton(),
              ],
            ),

            //Description
            Text(
              description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            //Volunteers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 5,
                children: mapVolunteers.keys
                    .map((work) => textVolunteer(work))
                    .toList(),
              ),
            ),

            // Time
            Row(
              children: [
                const SizedBox(width: 2),
                Icon(Icons.access_time, size: 20, color: Color(0xFF000000)),
                const SizedBox(width: 8),
                Text(
                  timeString,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textVolunteer(String volunteer) {
    return TextButton(
      onPressed: () {
        setState(() {
          if (mapIsSelected[volunteer] == true) {
            mapIsSelected.updateAll((work, _) => false);
          } else {
            mapIsSelected.updateAll((work, _) => work == volunteer);
          }
        });
      },
      style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
      child: Row(
        children: [
          mapIsSelected[volunteer] == true
              ? Icon(
                  Icons.radio_button_checked_outlined,
                  size: 24,
                  color: Colors.black,
                )
              : Icon(
                  Icons.radio_button_off_outlined,
                  size: 24,
                  color: Colors.black,
                ),
          SizedBox(width: 3),
          Text(
            volunteer,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _editButton() {
    Color mainColor = Theme.of(context).colorScheme.primary;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: CircleBorder(),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .push(
              MaterialPageRoute(builder: (_) => ModEvent(event: widget.event)),
            )
            .then((updatedEvent) {
              if (updatedEvent != null) {
                widget.modifyEvent(widget.index, updatedEvent);
              }
            });
      },
      child: Icon(Icons.mode_edit_outline_rounded, color: Colors.white),
    );
  }
}
