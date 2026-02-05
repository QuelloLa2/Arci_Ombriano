import 'package:arci_ombriano/Account/account_page.dart';
import 'package:arci_ombriano/Calendar/calendar_page.dart';
import 'package:arci_ombriano/Event/event_page.dart';
import 'package:arci_ombriano/Appbar/menu.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';
import 'package:arci_ombriano/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

import 'package:arci_ombriano/Utils/example_events.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('it_IT', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> titleText = ["Eventi", "Calendario", "Account"];
  int _activepage = 0;

  bool _menulist = false;

  @override
  Widget build(BuildContext context) {
    exampleEvents.sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    return Scaffold(
      appBar: TopBar(
        onPressed: menuListState,
        isOpen: _menulist,
        titlePage: titleText[_activepage],
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _activepage,
            children: [
              EventPage(listEvents: exampleEvents),
              CalendarPage(listEvents: exampleEvents),
              AccountPage(),
            ],
          ),
          _animationWidget(),
        ],
      ),
    );
  }

  void menuListState() {
    setState(() {
      _menulist = !_menulist;
    });
  }

  void changePage(int index) {
    setState(() {
      if (index != -1) {
        _activepage = index;
      }
      menuListState();
    });
  }

  AnimatedSwitcher _animationWidget() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: _menulist
          ? MenuAppBar(key: const ValueKey('menu'), changePage: changePage)
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}
