import 'package:arci_ombriano/Admin/mod_event.dart';
import 'package:flutter/material.dart';

class AddEventButton extends StatefulWidget {
  const AddEventButton({super.key});

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
        ).push(MaterialPageRoute(builder: (_) => ModEvent()));
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
