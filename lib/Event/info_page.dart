import 'package:arci_ombriano/Utils/role.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  final Event event;

  const InformationPage({
    super.key,
    required this.event,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 28,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.event.nameEvent,
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
                  _description(widget.event.description),
                  const SizedBox(height: 12),
                  _volunteer("Volontariato"),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      ...widget.event.mapVolunteers.entries.map(
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

  Widget _description(String data) {
    return Text(data, style: TextStyle(fontSize: 19, height: 1.45));
  }

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

  Widget _nameVolunteer(Role role, int nVolunteer, int maxVolunteer) {
    final List<String> names = widget.event.volunteers[role.name] ?? [];

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        margin: EdgeInsets.all(1),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 7.5),
                  Text(
                    role.name,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    "$nVolunteer/$maxVolunteer",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF181818),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              // Lista nomi volontari
              if (names.isNotEmpty) ...[
                SizedBox(height: 6),
                Divider(height: 1),
                SizedBox(height: 4),
                ...names.map(
                  (name) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7.5),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, size: 18, color: Colors.grey.shade600),
                        SizedBox(width: 6),
                        Text(name, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
