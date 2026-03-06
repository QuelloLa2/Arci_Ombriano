import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/example_things.dart';
import 'package:intl/intl.dart';

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
