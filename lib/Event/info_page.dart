import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatefulWidget {
  final String titleEvent;
  final String descEvent;
  final List<String> listVolunteers;

  const InformationPage({
    super.key,
    required this.titleEvent,
    required this.descEvent,
    required this.listVolunteers,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  //Appbar

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 32),
      ),
      title: Text(
        widget.titleEvent,
        style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _body() {
    List<String> volunteer = widget.listVolunteers;

    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _description(widget.descEvent),
          const SizedBox(height: 15),
          _volunteer("Volontariato"),
          const SizedBox(height: 20),
          ...volunteer.map((work) => _buttonVolunteer(work)),
        ],
      ),
    );
  }

  //Description

  Text _description(String data) {
    return Text(widget.descEvent, style: GoogleFonts.poppins(fontSize: 22));
  }

  //Title Volunteer

  Text _volunteer(String data) {
    return Text(
      data,
      style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
    );
  }

  // Button Volunteer

  Widget _buttonVolunteer(String volunteer) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          print(volunteer);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7.5,
          shadowColor: Color.fromARGB(255, 0, 0, 0),
        ),
        child: Row(
          children: [
            Icon(Icons.circle_outlined, size: 32),
            SizedBox(width: 10),
            Text(volunteer, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
