import 'package:flutter/material.dart';
import 'package:arci_ombriano/app_theme.dart';

Widget textField(String label) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gapPadding: 2.5,
      ),
      labelText: label,
    ),
  );
}

Widget button(String label) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(18)),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(
        label,
        textScaler: TextScaler.linear(2),
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
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
