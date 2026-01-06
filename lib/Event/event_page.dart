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

    String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

    return Column(
      children: [
        _titleEvent(mainText),
        _dateTitle("- venerdì 14/04 ", dateColor),
        _eventButton("Grassi's Night", text, "19:00"),
      ],
    );
  }

  // Title
  Widget _titleEvent(Color color) {
    return Container(
      height: 50,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
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
      height: 50,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 40),
      child: Text(
        date,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: -0.7,
        ),
      ),
    );
  }

  //Event main details
  Widget _eventButton(String titleEvent, String description, String timeEvent) {
    return Container(
      height: 150,
      width: 350,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Color(0x681A0704), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleEvent),
          SizedBox(height: 45,child: Text(description)),
        ],
      ),
    );
  }
}
