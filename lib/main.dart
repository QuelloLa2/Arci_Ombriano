import 'package:arci_ombriano/Account/account_page.dart';
import 'package:arci_ombriano/Calendar/calendar_page.dart';
import 'package:arci_ombriano/Event/event_page.dart';
import 'package:arci_ombriano/Appbar/menu.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

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
    //Example
    String text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

    Map<String, Map<String, int>> mapVolunteers = {
      'Cuoco': {'Current': 1, 'Max': 2},
      'Audio': {'Current': 1, 'Max': 3},
      'Aiuto': {'Current': 1, 'Max': 4},
    };

    Event event = Event(
      "Grassi's Night",
      DateTime(2025, 4, 14, 19, 00),
      text,
      mapVolunteers,
    );

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
              EventPage(cEvent: event),
              CalendarPage(),
              AccountPage(),
            ],
          ),
          if (_menulist) MenuAppBar(changePage: changePage),
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
      _activepage = index;
      menuListState();
    });
  }
}
