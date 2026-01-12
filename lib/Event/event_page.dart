import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    Color mainText = Theme.of(context).colorScheme.primary;
    Color dateColor = Color(0xFF1A0704);

    String text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

    List<String> works = ["Cuoco", "Audio", "Aiuto"];

    return Column(
      children: [
        _titleEvent(mainText),
        const SizedBox(height: 10),
        _dateTitle("-Venerdì 14/04 ", dateColor),
        const SizedBox(height: 10),
        _eventButton("Grassi's Night", text, "19:00", works),
      ],
    );
  }

  // Title
  Widget _titleEvent(Color color) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15,left: 20),
      child: Text(
        "Prossimi Eventi",
        style: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: -0.7,
        ),
      ),
    );
  }

  // Title date
  Widget _dateTitle(String date, Color color) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 35),
      child: Text(
        date,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: -0.7,
        ),
      ),
    );
  }

  //Event main details
  Widget _eventButton(String title, String description, String time, List<String> volunteers) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
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
              fontSize: 20,
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
            overflow: TextOverflow.ellipsis
          ),
          const SizedBox(height: 6),

          //Volunteers

          Row(
            spacing: 15,
            children: volunteers.map((work) => textVolunteer(work)).toList(),
          ),
          const SizedBox(height: 6),

          // Time

          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.black),
              const SizedBox(width: 6),
              Text(time, style: GoogleFonts.poppins(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Row textVolunteer(String data){
    return Row(
      children: [
        Icon(Icons.circle_outlined, color: Colors.black),
        SizedBox(width: 3),
        Text(data, style: GoogleFonts.poppins(fontSize: 18)),
      ],
    );
  }

}
