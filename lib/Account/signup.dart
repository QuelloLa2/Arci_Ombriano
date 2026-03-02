import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Benvenuto!",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
          ),
          SizedBox(height: 10),
          //textField("Nome"),
          //SizedBox(height: 10),
          //textField("Cognome"),
          //SizedBox(height: 10),
          //textField("Email"),
          //SizedBox(height: 10),
          //button("Registrati"),
          //SizedBox(height: 10),
          //textButton("Hai gia un account?"),
        ],
      ),
    );
  }
}
