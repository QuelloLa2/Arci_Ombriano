import 'package:arci_ombriano/Utils/example_things.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModEvent extends StatefulWidget {
  const ModEvent({super.key, this.event});

  final Event? event;
  @override
  State<ModEvent> createState() => _ModEventState();
}

class _ModEventState extends State<ModEvent> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;

  DateFormat stdDate = DateFormat('dd/MM/yyyy');
  DateFormat stdTime = DateFormat('HH:mm');
  DateFormat stdDateTime = DateFormat('dd-MM-yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.event?.nameEvent ?? '',
    );
    _descController = TextEditingController(
      text: widget.event?.description ?? '',
    );
    _dateController = TextEditingController(
      text: stdDate.format(widget.event?.dateEvent ?? DateTime.now()),
    );
    _timeController = TextEditingController(
      text: stdTime.format(widget.event?.timeEvent ?? DateTime.now()),
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _inputField("Titolo", _titleController),
          SizedBox(height: 25),
          _descField("Descrizione", _descController),
          SizedBox(height: 25),
          Row(
            spacing: 20,
            children: [
              Expanded(child: _dateField("Data", _dateController)),
              Expanded(child: _timeField("Ora", _timeController)),
            ],
          ),
          Expanded(child: SizedBox()),
          Row(spacing: 7, children: [_deleteButton(), _confermButton()]),
        ],
      ),
    );
  }

  //Title Field

  Widget _inputField(String label, TextEditingController controller) {
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

  //Description Field

  Widget _descField(String label, TextEditingController controller) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      maxLength: null,
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

  // Date Field
  Widget _dateField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickDate = await showDatePicker(
          context: context,
          locale: const Locale('it', 'IT'),
          initialDate: widget.event?.dateEvent ?? DateTime.now(),
          firstDate: DateTime(2026, 1, 1),
          lastDate: DateTime(2030, 12, 31),
        );

        if (pickDate != null) {
          setState(() {
            controller.text = stdDate.format(pickDate);
          });
        }
      },
    );
  }

  // Time Field
  Widget _timeField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      readOnly: true,
      onTap: () async {
        Event? event = widget.event;
        TimeOfDay? time;

        if (event != null) {
          time = TimeOfDay(
            hour: event.timeEvent.hour,
            minute: event.timeEvent.minute,
          );
        }
        TimeOfDay? pickDate = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );

        if (pickDate != null) {
          setState(() {
            DateTime time = DateTime(0, 0, 0, pickDate.hour, pickDate.minute);
            controller.text = stdTime.format(time);
          });
        }
      },
    );
  }

  Widget _deleteButton() {
    Color backColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, {'delete': true, 'event': widget.event});
        },
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
            Event? event = widget.event;

            DateTime newDateTime = _formatDate(
              _dateController.text,
              _timeController.text,
            );

            if (event != null) {
              Event updateEvent = event.copyWith(
                nameEvent: _titleController.text,
                description: _descController.text,
                timeEvent: newDateTime,
              );
              Navigator.pop(context, {'delete': false, 'event': updateEvent});
            }
            if (event == null) {
              exampleId++;

              Event newEvent = Event(
                id: exampleId,
                nameEvent: _titleController.text,
                description: _descController.text,
                timeEvent: newDateTime,
                mapVolunteers: {
                  'Cuoco': {'Current': 2, 'Max': 2},
                  'Audio': {'Current': 2, 'Max': 3},
                  'Cameriere': {'Current': 1, 'Max': 4},
                },
              );
              Navigator.pop(context, {'event': newEvent});
            }
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

  DateTime _formatDate(String date, String time) {
    DateTime pickedDate = stdDate.parse(date);
    DateTime pickedTime = stdTime.parse(time);

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}
