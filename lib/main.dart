import 'package:arci_ombriano/Account/account_page.dart';
import 'package:arci_ombriano/Calendar/calendar_page.dart';
import 'package:arci_ombriano/Event/event_page.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';
import 'package:arci_ombriano/Utils/menu_button.dart';
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

  @override
  Widget build(BuildContext context) {
    exampleEvents.sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    final List<Widget> pages = [
      EventPage(listEvents: exampleEvents),
      CalendarPage(listEvents: exampleEvents),
      AccountPage(),
    ];

    return Scaffold(
      appBar: TopBar(titlePage: titleText[_activepage]),
      body: Stack(children: [pages.elementAt(_activepage)]),
      floatingActionButton: AddEventButton(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_rounded),
            label: "Eventi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendario",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Account",
          ),
        ],
        currentIndex: _activepage,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _activepage = index;
    });
  }
}
