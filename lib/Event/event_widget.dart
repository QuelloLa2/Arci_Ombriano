import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arci_ombriano/Event/info_page.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    required this.nameEvent,
    required this.description,
    required this.time,
    required this.mapVolunteer,
    required this.primary,
  });

  final String nameEvent;
  final String description;
  final DateTime time;
  final Map<String, Map<String, int>> mapVolunteer;
  final Color primary;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    String timeString = DateFormat("HH:mm").format(widget.time);

    return InkWell(
      enableFeedback: false,
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => InformationPage(
              titleEvent: widget.nameEvent,
              descEvent: widget.description,
              mapVolunteers: widget.mapVolunteer,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 5),
        padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 8),
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
            Text(
              widget.nameEvent,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),

            //Description
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            //Volunteers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 20,
                children: widget.mapVolunteer.keys
                    .map((work) => textVolunteer(work))
                    .toList(),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(width: 10),
                // Time
                Icon(Icons.access_time, size: 24, color: Color(0xFF000000)),
                const SizedBox(width: 8),
                Text(
                  timeString,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Create Volunteer Row
Widget textVolunteer(String data) {
  return Row(
    children: [
      Icon(Icons.radio_button_checked_outlined, color: Colors.black),
      SizedBox(width: 3),
      Text(
        data,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
