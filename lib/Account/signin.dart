import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/user.dart';
import 'package:arci_ombriano/API/account.dart' as api;
import 'package:arci_ombriano/Utils/storage.dart' as data;
import 'package:arci_ombriano/Account/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key, required this.onLoginSuccess});

  final Function(User user) onLoginSuccess;
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
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            _textField("Email", _emailController),
            SizedBox(height: 10),
            _button("Accedi"),
            SizedBox(height: 10),
            _textButton("Non hai ancora un account?"),
            SizedBox(height: 10),
          ],
        ),
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
        onPressed: () async {
          if (_emailController.text.isEmpty) return;

          final (user, success) = await api.logIn(_emailController.text);

          if (success && user != null) {
            await data.storage.write(key: 'token', value: user.token);
            await data.storage.write(key: 'user_id', value: user.id.toString());
            await data.storage.write(key: 'user_name', value: user.name);
            await data.storage.write(
              key: 'is_admin',
              value: user.isAdmin.toString(),
            );

            widget.onLoginSuccess(user);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Email non trovata")));
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

  Widget _textField(String label, TextEditingController controller) {
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

  Widget _textButton(String label) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SignupPage(onLoginSuccess: widget.onLoginSuccess),
            ),
          );
        },
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
