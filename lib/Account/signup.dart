import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(67),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Benvenuto!", style: TextStyle()),
          SizedBox(height: 10),
          _textField("Nome"),
          SizedBox(height: 10),
          _textField("Cognome"),
          SizedBox(height: 10),
          _textField("Email"),
        ],
      ),
    );
  }

  Widget _textField(String label) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gapPadding: 7.5,
        ),
        labelText: label,
      ),
    );
  }
}
