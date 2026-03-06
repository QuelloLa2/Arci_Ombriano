import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Widget inputField(String label, TextEditingController controller) {
  return TextField(
    inputFormatters: [LengthLimitingTextInputFormatter(36)],
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

Widget descField(String label, TextEditingController controller) {
  return TextField(
    keyboardType: TextInputType.multiline,
    maxLines: 9,
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

Widget dateField(
  String label,
  TextEditingController controller,
  DateFormat stdDate,
  BuildContext context,
  Event? event,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(border: OutlineInputBorder(), labelText: label),
    readOnly: true,
    onTap: () async {
      DateTime? pickDate = await showDatePicker(
        context: context,
        locale: const Locale('it', 'IT'),
        initialDate: event?.dateEvent ?? DateTime.now(),
        firstDate: DateTime(2026, 1, 1),
        lastDate: DateTime(2030, 12, 31),
      );

      if (pickDate != null) {
        controller.text = stdDate.format(pickDate);
      }
    },
  );
}

Widget timeField(
  String label,
  TextEditingController controller,
  DateFormat stdTime,
  BuildContext context,
  Event? event,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(border: OutlineInputBorder(), labelText: label),
    readOnly: true,
    onTap: () async {
      TimeOfDay initialTime;

      if (event != null) {
        initialTime = TimeOfDay(
          hour: event.timeEvent.hour,
          minute: event.timeEvent.minute,
        );
      } else {
        initialTime = TimeOfDay.now();
      }

      TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickTime != null) {
        final now = DateTime.now();
        final time = DateTime(
          now.year,
          now.month,
          now.day,
          pickTime.hour,
          pickTime.minute,
        );

        controller.text = stdTime.format(time);
      }
    },
  );
}
