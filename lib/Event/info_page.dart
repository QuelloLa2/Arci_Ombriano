import 'package:flutter/material.dart';

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
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 28),
      ),
      title: Text(
        widget.titleEvent,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  const SizedBox(height: 12),
                  _volunteer("Volontariato"),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      ...widget.mapVolunteers.entries.map(
                        (work) => _nameVolunteer(
                          work.key,
                          work.value['Current'] ?? 0,
                          work.value['Max'] ?? 0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
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
    return Text(data, style: TextStyle(fontSize: 19, height: 1.45));
  }

  //Title Volunteer

  ListTile _volunteer(String data) {
    return ListTile(
      leading: Text(
        data,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Button Volunteer

  Widget _nameVolunteer(String volunteer, int nVolunteer, int maxVolunteer) {
    String textVolunteer = "$nVolunteer/$maxVolunteer";

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        margin: EdgeInsets.all(1),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 7.5),
                  Text(
                    volunteer,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    textVolunteer,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF181818),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Column(
                children: [
                  Text("Persona 1"),
                  Text("Persona 2"),
                  Text("Persona 3"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
