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
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        child: Image.asset('assets/Images/logo.png'),
      ),
      centerTitle: true,
      title: Text(
        widget.titlePage,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
      ),
    );
  }
}
