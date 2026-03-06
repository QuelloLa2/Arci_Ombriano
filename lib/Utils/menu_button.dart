import 'package:arci_ombriano/Admin/mod_event.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';

class AddEventButton extends StatefulWidget {
  const AddEventButton({super.key, required this.addEvent});

  final Function(Event) addEvent;

  @override
  State<AddEventButton> createState() => _AddEventButtonState();
}

class _AddEventButtonState extends State<AddEventButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: () {
        Navigator.of(
          context,
          rootNavigator: true,
        ).push(MaterialPageRoute(builder: (_) => ModEvent())).then((result) {
          if (result != null && result['event'] != null) {
            widget.addEvent(result['event']);
          }
        });
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
