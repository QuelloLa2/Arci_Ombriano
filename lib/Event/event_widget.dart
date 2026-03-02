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
    required this.isAdmin,
    required this.modifyEvent,
    required this.deleteEvent,
  });

  final int index;
  final Event event;
  final Color primary;
  final Function(int, Event) modifyEvent;
  final Function(Event) deleteEvent;
  final bool isAdmin;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  late Map<String, bool> mapIsSelected = {};

  @override
  void initState() {
    mapIsSelected = {
      for (final key in widget.event.mapVolunteers.keys) key: false,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    String timeString = DateFormat("HH:mm").format(event.timeEvent);

    return InkWell(
      enableFeedback: false,
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
                  event.nameEvent,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Expanded(child: SizedBox()),

                widget.isAdmin ? _editButton() : SizedBox(),
              ],
            ),

            //Description
            Text(
              event.description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            //Volunteers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 5,
                children: event.mapVolunteers.keys
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
            .then((result) {
              if (result != null) {
                if (!result['delete'] && result['event'] != null) {
                  widget.modifyEvent(widget.index, result['event']);
                }
                if (result['delete'] && result['event'] != null) {
                  widget.deleteEvent(result['event']);
                }
              }
            });
      },
      child: Icon(Icons.mode_edit_outline_rounded, color: Colors.white),
    );
  }
}
