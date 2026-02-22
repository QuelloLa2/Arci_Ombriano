import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';

class ModEvent extends StatefulWidget {
  const ModEvent({super.key, this.event});

  final Event? event;
  @override
  State<ModEvent> createState() => _ModEventState();
}

class _ModEventState extends State<ModEvent> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.event?.nameEvent ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
        "Creazione Evento",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: _textField("Titolo", _titleController)),
          Row(spacing: 7, children: [_deleteButton(), _confermButton()]),
        ],
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gapPadding: 7.5,
        ),
        labelText: label,
      ),
    );
  }

  Widget _deleteButton() {
    Color backColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: backColor,
          foregroundColor: Colors.white,
        ),
        child: Icon(Icons.delete, size: 26),
      ),
    );
  }

  Widget _confermButton() {
    Color backColor = Theme.of(context).colorScheme.primary;

    return Expanded(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.event!.nameEvent = _titleController.text;
            });

            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backColor,
            foregroundColor: Colors.white,
          ),
          child: Text("Conferma", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
