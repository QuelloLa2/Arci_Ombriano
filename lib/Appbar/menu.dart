import 'package:flutter/material.dart';

class MenuAppBar extends StatelessWidget {
  final Function(int) changePage;
  final Color _transparency = Color.fromARGB(160, 255, 255, 255);

  MenuAppBar({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    double space = 15;

    return Column(
      children: [
        _box(space),
        _selectpage("Eventi", context, 0),
        _box(space),
        _selectpage("Calendario", context, 1),
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: ElevatedButton(
          onPressed: () => changePage(index),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.backgroundColor,
            foregroundColor: theme.foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              switch (pageName) {
                "Eventi" => Icon(
                  Icons.event,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                "Calendario" => Icon(
                  Icons.calendar_month_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                "Account" => Icon(
                  Icons.account_box_rounded,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                _ => const SizedBox(),
              },
              Text(
                pageName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container for spacing

  Widget _box(double height) {
    return InkWell(
      onTap: () => changePage(-1),
      child: Container(
        width: double.infinity,
        height: height,
        color: _transparency,
      ),
    );
  }
}
