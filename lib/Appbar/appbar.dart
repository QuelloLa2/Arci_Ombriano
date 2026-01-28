import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final bool isOpen;
  final String titlePage;

  const TopBar({
    super.key,
    required this.onPressed,
    required this.isOpen,
    required this.titlePage,
  });

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  late final AnimationController _animationControll;

  //Create widget
  @override
  void initState() {
    super.initState();
    _animationControll = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.isOpen) _animationControll.value = 1.0;
  }

  //Rebuild widget on condition
  @override
  void didUpdateWidget(TopBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isOpen != oldWidget.isOpen) {
      widget.isOpen
          ? _animationControll.forward()
          : _animationControll.reverse();
    }
  }

  @override
  void dispose() {
    _animationControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationControll,
        ),
        onPressed: widget.onPressed,
      ),
      centerTitle: true,
      title: Text(
        widget.titlePage,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 26),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 9, bottom: 9, right: 16),
          child: Image.asset('lib/Images/logo.png'),
        ),
      ],
    );
  }
}
