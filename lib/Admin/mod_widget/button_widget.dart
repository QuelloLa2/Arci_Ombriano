import 'package:arci_ombriano/Utils/role.dart';
import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/API/event.dart' as api;
import 'package:intl/intl.dart';

Widget deleteButton(BuildContext context, Event? event) {
  Color backColor = Theme.of(context).colorScheme.primary;
  return SizedBox(
    height: 60,
    child: ElevatedButton(
      onPressed: () async {
        if (event?.id == null) return;
        print('Attempting to delete event with id: ${event!.id}');
        final success = await api.deleteEvent(event.id!);
        print('Delete event result: $success');
        if (success && context.mounted) {
          Navigator.pop(context, {'delete': true, 'event': event});
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Errore durante l\'eliminazione')),
          );
        }
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
  Map<Role, TextEditingController> mapSelVolunteers,
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

          Map<Role, Map<String, int>> buildVolunteers() {
            return Map.fromEntries(
              mapSelVolunteers.entries.map(
                (entry) => MapEntry(
                  Role(id: entry.key.id, name: entry.key.name),
                  {'Current': 0, 'Max': int.tryParse(entry.value.text) ?? 0},
                ),
              ),
            );
          }

          if (event != null) {
            Event updateEvent = event.copyWith(
              nameEvent: titleController.text,
              description: descController.text,
              timeEvent: newDateTime,
              mapVolunteers: buildVolunteers(),
            );
            Navigator.pop(context, {'delete': false, 'event': updateEvent});
          }

          if (event == null) {
            Event newEvent = Event(
              nameEvent: titleController.text,
              description: descController.text,
              timeEvent: newDateTime,
              mapVolunteers: buildVolunteers(),
            );
            api.addEvent(newEvent);
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
