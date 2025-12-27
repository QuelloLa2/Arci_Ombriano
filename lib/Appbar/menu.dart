import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {

  //Animated Icon Var
  late final AnimationController _animationControll;
  bool _isAnimating = false;


  //AppBar build
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _menubutton(),
      centerTitle: true,
      title: const Text("Text"),
    );
  }


  // Animated Icon 
  Widget _menubutton() {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animationControll,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          _isAnimating = !_isAnimating;
          _isAnimating
              ? _animationControll.forward()
              : _animationControll.reverse();
        });
      },
    );
  }

  //Icon Animation
  @override
  void initState() {
    super.initState();
    _animationControll = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

}
