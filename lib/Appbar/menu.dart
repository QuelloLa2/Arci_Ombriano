import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget {
  const MenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: double.infinity, height: 50, color: Colors.cyan),
        Container(width: double.infinity, height: 50, color: Colors.blue),
        Container(width: double.infinity, height: 50, color: Colors.teal),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Color.fromARGB(160, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
