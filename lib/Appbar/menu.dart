import 'package:flutter/material.dart';

//TODO: set route for the pages

class MenuAppBar extends StatelessWidget {
  const MenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double space = 12.5;

    return Column(
      children: [
        _box(space),
        _selectpage("1", context),
        _box(space),
        _selectpage("2", context),
        _box(space),
        _selectpage("3", context),
        Expanded(child: _box(double.infinity)),
      ],
    );
  }

  // Creating button

  Widget _selectpage(String pageName, BuildContext context) {
    final theme = AppBarTheme.of(context);

    return Container(
      color: Color.fromARGB(160, 255, 255, 255),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: TextButton(
          onPressed: () {},
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
      color: const Color.fromARGB(160, 255, 255, 255),
    );
  }
}
