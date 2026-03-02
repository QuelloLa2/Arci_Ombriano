import 'package:flutter/material.dart';
import 'package:arci_ombriano/app_theme.dart';

Widget textField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gapPadding: 2.5,
      ),
      labelText: label,
    ),
  );
}

Widget textButton(String label) {
  return Center(
    child: TextButton(
      onPressed: () {},
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    ),
  );
}
