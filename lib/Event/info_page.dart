import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  final String titleEvent;

  const InformationPage({super.key, required this.titleEvent});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(child: Container(color: Colors.yellow)),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 32),
      ),
      title: Text(widget.titleEvent),
    );
  }
}
