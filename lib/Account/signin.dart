import 'package:flutter/material.dart';
import 'package:arci_ombriano/Account/widgets.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bentornato!",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
          ),
          SizedBox(height: 10),
          textField("Email"),
          SizedBox(height: 10),
          button("Accedi"),
          SizedBox(height: 10),
          textButton("Non hai ancora un account?"),
        ],
      ),
    );
  }
}
