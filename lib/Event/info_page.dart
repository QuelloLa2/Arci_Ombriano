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
          _confirmButton(),
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
            mapIsSelected.updateAll((work, _) => work == volunteer);
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

  // Button Confirm
  Widget _confirmButton() {
    Color buttonColor = Theme.of(context).colorScheme.primary;
    Color textColors = Color(0xFF101010);

    return SizedBox(
      height: 75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8,
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: buttonColor,
        ),
        onPressed: !_buttonDisabled()
            ? null
            : () => {
                showDialog<String>(
                  context: context,
                  builder: (context) => _goodEnding(),
                ),
              },
        child: Center(
          child: Text(
            "CONFERMA",
            style: GoogleFonts.poppins(
              color: !_buttonDisabled() ? Colors.black38 : textColors,
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  bool _buttonDisabled() {
    for (bool enable in mapIsSelected.values) {
      if (enable) return true;
    }

    return false;
  }

  AlertDialog _goodEnding() {
    return AlertDialog(
      title: Text("Conferma"),
      content: Text("Vuoi confermare la disponibilità all'evento?"),
      actions: [
        TextButton(
          onPressed: () => {Navigator.pop(context), Navigator.pop(context)},
          child: Text("No"),
        ),
        TextButton(
          onPressed: () => {Navigator.pop(context), Navigator.pop(context)},
          child: Text("Si"),
        ),
      ],
    );
  }
}
