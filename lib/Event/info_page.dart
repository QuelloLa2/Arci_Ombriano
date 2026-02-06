import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatefulWidget {
  final String titleEvent;
  final String descEvent;
  final Map<String, Map<String, int>> mapVolunteers;

  const InformationPage({
    super.key,
    required this.titleEvent,
    required this.descEvent,
    required this.mapVolunteers,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late Map<String, bool> mapIsSelected = {};

  @override
  void initState() {
    super.initState();
    mapIsSelected = {for (final key in widget.mapVolunteers.keys) key: false};
  }

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
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _description(widget.descEvent),
                  const SizedBox(height: 15),
                  _volunteer("Volontariato"),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ...widget.mapVolunteers.entries.map(
                        (work) => _buttonVolunteer(
                          work.key,
                          work.value['Current'] ?? 0,
                          work.value['Max'] ?? 0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Description

  Widget _description(String data) {
    return Text(data, style: GoogleFonts.poppins(fontSize: 22, height: 1.45));
  }

  //Title Volunteer

  ListTile _volunteer(String data) {
    return ListTile(
      leading: Text(
        data,
        style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.group, size: 30)),
    );
  }

  // Button Volunteer

  Widget _buttonVolunteer(String volunteer, int nVolunteer, int maxVolunteer) {
    String textVolunteer = "$nVolunteer/$maxVolunteer";

    return Container(
      height: 60,
      padding: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3.5,
          shadowColor: Color.fromARGB(255, 0, 0, 0),
        ),
        onPressed: () {
          setState(() {
            if (mapIsSelected[volunteer] == true) {
              mapIsSelected.updateAll((work, _) => false);
            } else {
              mapIsSelected.updateAll((work, _) => work == volunteer);
            }
          });
        },
        child: Row(
          children: [
            mapIsSelected[volunteer] == true
                ? Icon(Icons.circle, size: 32)
                : Icon(Icons.circle_outlined, size: 32),
            SizedBox(width: 10),
            Text(
              volunteer,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              textVolunteer,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF181818),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
