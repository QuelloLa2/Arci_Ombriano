import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String titlePage;

  const TopBar({super.key, required this.titlePage});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/Images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.titlePage,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
