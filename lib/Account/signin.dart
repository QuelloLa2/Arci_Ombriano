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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  size: 80,
                  color: Color(0xFFC74E43),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Bentornato!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Accedi per continuare",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7B8284),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                _textField("Email", _emailController, Icons.email_outlined),
                const SizedBox(height: 20),
                _button("Accedi"),
                const SizedBox(height: 16),
                _textButton("Non hai ancora un account?"),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(String label) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
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
        child: Text(label),
      ),
    );
  }

  Widget _textField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF7B8284)),
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
        child: Text(label),
      ),
    );
  }
}
