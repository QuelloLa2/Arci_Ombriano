import 'package:flutter/material.dart';
import 'package:arci_ombriano/Account/widgets.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<SigninPage> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

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
          textField("Email", _emailController),
          SizedBox(height: 10),
          _button("Accedi"),
          SizedBox(height: 10),
          textButton("Non hai ancora un account?"),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _button(String label) {
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
        onPressed: () {
          if (_emailController.text.isEmpty) {
            print("scrivi qualcosa dai");
          } else {
            print("bravo");
          }
        },
        child: Text(
          label,
          textScaler: TextScaler.linear(2),
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
