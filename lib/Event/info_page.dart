import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatefulWidget {
  final String titleEvent;
  final String descEvent;

  const InformationPage({
    super.key,
    required this.titleEvent,
    required this.descEvent,
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
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 32),
      ),
      title: Text(
        widget.titleEvent,
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.descEvent, style: GoogleFonts.poppins(fontSize: 22)),
          SizedBox(height: 15),
          Text(
            "Volontariato",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
