import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/example_things.dart';
import 'package:intl/intl.dart';
import 'package:arci_ombriano/API/add_event.dart';

Widget deleteButton(BuildContext context, Event? event) {
  Color backColor = Theme.of(context).colorScheme.primary;

  return SizedBox(
    height: 60,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pop(context, {'delete': true, 'event': event});
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

Widget confermButton(
  BuildContext context,
  Event? event,
  TextEditingController titleController,
  TextEditingController descController,
  TextEditingController dateController,
  TextEditingController timeController,
  Map<String, TextEditingController> mapSelVolunteers,
  DateFormat stdDate,
  DateFormat stdTime,
) {
  Color backColor = Theme.of(context).colorScheme.primary;

  return Expanded(
    child: SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          DateTime newDateTime = _formatDate(
            dateController.text,
            timeController.text,
            stdDate,
            stdTime,
          );

          if (event != null) {
            Event updateEvent = event.copyWith(
              nameEvent: titleController.text,
              description: descController.text,
              timeEvent: newDateTime,
              mapVolunteers: Map.fromEntries(
                mapSelVolunteers.entries.map(
                  (role) => MapEntry(role.key, {
                    'Current': 0,
                    'Max': int.parse(role.value.text),
                  }),
                ),
              ),
            );
            Navigator.pop(context, {'delete': false, 'event': updateEvent});
          }
          if (event == null) {
            exampleId++;

            Event newEvent = Event(
              id: exampleId,
              nameEvent: titleController.text,
              description: descController.text,
              timeEvent: newDateTime,
              mapVolunteers: Map.fromEntries(
                mapSelVolunteers.entries.map(
                  (role) => MapEntry(role.key, {
                    'Current': 0,
                    'Max': int.parse(role.value.text),
                  }),
                ),
              ),
            );
            addEvent(newEvent);
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

DateTime _formatDate(
  String date,
  String time,
  DateFormat stdDate,
  DateFormat stdTime,
) {
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
