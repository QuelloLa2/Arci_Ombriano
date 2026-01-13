import 'package:arci_ombriano/Event/info_page.dart';
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
    Color mainColor = Theme.of(context).colorScheme.primary;
    Color dateColor = Color(0xFF1A0704);

    String titleEvent = "Grassi's Night";

    String text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

    List<String> works = ["Cuoco", "Audio", "Aiuto"];

    return Column(
      children: [
        _titleEvent(mainColor),
        const SizedBox(height: 25),
        _dateTitle("-Venerdì 14/04 ", dateColor),
        const SizedBox(height: 15),
        _eventButton(titleEvent, text, "19:00", works, mainColor),
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
  Widget _dateTitle(String date, Color color) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 35),
      child: Text(
        date,
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
    String time,
    List<String> volunteers,
    Color primary,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 245, 245),
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
          Row(
            spacing: 20,
            children: volunteers.map((work) => textVolunteer(work)).toList(),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const SizedBox(width: 10),

              // Time
              Icon(Icons.access_time, size: 24, color: Color(0xFF000000)),
              const SizedBox(width: 8),
              Text(
                time,
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
                          listVolunteers: volunteers,
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

  Row textVolunteer(String data) {
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
