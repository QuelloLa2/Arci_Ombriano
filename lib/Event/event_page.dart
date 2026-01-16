import 'package:arci_ombriano/Event/info_page.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.cEvent});

  final Event cEvent;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.primary;
    Color dateColor = Color(0xFF1A0704);
    return Column(
      children: [
        _titleEvent(mainColor),
        const SizedBox(height: 25),
        _dateTitle(widget.cEvent.dateEvent, dateColor),
        const SizedBox(height: 15),
        _eventButton(
          widget.cEvent.nameEvent,
          widget.cEvent.description,
          widget.cEvent.dateEvent,
          widget.cEvent.mapVolunteers,
          mainColor,
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
    String dateString = DateFormat("- EEEE dd/MM", 'it_IT').format(date);

    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 35),
      child: Text(
        dateString,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: -0.7,
        ),
      ),
    );
  }

  //Event main details
  Widget _eventButton(
    String title,
    String description,
    DateTime time,
    Map<String, Map<String, int>> mapVolunteer,
    Color primary,
  ) {
    String timeString = DateFormat("HH:mm").format(time);

    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
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
            title,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),

          //Description
          Text(
            description,
            style: GoogleFonts.poppins(
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
              children: mapVolunteer.keys
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
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Info
              Expanded(child: SizedBox()),
              SizedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll<Color>(
                      Color(0xFFE6E6E6),
                    ),
                    elevation: const WidgetStatePropertyAll<double>(2),
                    shadowColor: WidgetStatePropertyAll<Color>(primary),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) => InformationPage(
                          titleEvent: title,
                          descEvent: description,
                          mapVolunteers: mapVolunteer,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        "Info",
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 19,
                        color: primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget textVolunteer(String data) {
    return Row(
      children: [
        Icon(Icons.radio_button_checked_outlined, color: Colors.black),
        SizedBox(width: 3),
        Text(
          data,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
