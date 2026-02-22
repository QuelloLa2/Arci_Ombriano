import 'package:arci_ombriano/Account/signup.dart';
import 'package:arci_ombriano/Calendar/calendar_page.dart';
import 'package:arci_ombriano/Event/event_page.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';
import 'package:arci_ombriano/menu_button.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> titleText = ["Calendario", "Eventi", "Account"];

  int _activepage = 1;

  @override
  Widget build(BuildContext context) {
    exampleEvents.sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    final List<Widget> pages = [
      CalendarPage(listEvents: exampleEvents),
      EventPage(listEvents: exampleEvents, modifyEvent: _editEvent),
      AccountPage(),
    ];

    return Scaffold(
      appBar: TopBar(titlePage: titleText[_activepage]),
      body: Stack(children: [pages.elementAt(_activepage)]),
      floatingActionButton: AddEventButton(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _activepage = index;
    });
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Color(0xFF7B8284),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: 24,
      selectedFontSize: 15,
      enableFeedback: true,
      items: [
        _item(Icons.calendar_month, "Calendario"),
        _item(Icons.event_note, "Eventi"),
        _item(Icons.account_circle_rounded, "Account"),
      ],
      currentIndex: _activepage,
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _item(IconData icon, String data) {
    return BottomNavigationBarItem(icon: Icon(icon), label: data);
  }

  void _editEvent(int index, Event updatedEvent) {
    setState(() {
      exampleEvents[index] = updatedEvent;
    });
  }
}
