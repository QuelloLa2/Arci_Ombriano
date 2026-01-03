import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget {
  final Function(int) changePage;
  final Color _transparency = Color.fromARGB(160, 255, 255, 255);

  MenuAppBar({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    double space = 12.5;

    return Column(
      children: [
        _box(space),
        _selectpage("Event", context, 0),
        _box(space),
        _selectpage("Calendar", context, 1),
        _box(space),
        _selectpage("Account", context, 2),
        Expanded(child: _box(double.infinity)),
      ],
    );
  }

  // Creating button

  Widget _selectpage(String pageName, BuildContext context, int index) {
    final theme = AppBarTheme.of(context);

    return Container(
      color: _transparency,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: TextButton(
          onPressed: () => changePage(index),
          style: TextButton.styleFrom(
            backgroundColor: theme.backgroundColor,
            foregroundColor: theme.foregroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(pageName),
        ),
      ),
    );
  }

  // Container for spacing

  Widget _box(double height) {
    return Container(
      width: double.infinity,
      height: height,
      color: _transparency,
    );
  }
}
