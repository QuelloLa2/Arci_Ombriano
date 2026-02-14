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
        print("Ciao");
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
