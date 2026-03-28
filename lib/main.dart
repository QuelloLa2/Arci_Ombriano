import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:arci_ombriano/app_theme.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';
import 'package:arci_ombriano/Calendar/calendar_page.dart';
import 'package:arci_ombriano/Account/signin.dart';
import 'package:arci_ombriano/Event/event_page.dart';
import 'package:arci_ombriano/Setting/setting_page.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/menu_button.dart';
import 'package:arci_ombriano/Utils/example_things.dart';
import 'package:arci_ombriano/API/event.dart' as api;
import "package:flutter_secure_storage/flutter_secure_storage.dart";

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
      locale: const Locale('it', 'IT'),
      supportedLocales: const [Locale('it', 'IT')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
  final storage = FlutterSecureStorage();

  List<Event> events = [];

  final List<String> titleText = ["Calendario", "Eventi", "Account", "Setting"];

  int _activepage = 1;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final (fetchedEvents, success) = await api.getEvent();

    if (success && fetchedEvents != null) {
      setState(() {
        events = fetchedEvents;
        events = _sortEvents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CalendarPage(listEvents: events),
      EventPage(
        listEvents: events,
        isAdmin: user.isAdmin,
        modifyEvent: _editEvent,
        addEvent: _addEvent,
        deleteEvent: _deleteEvent,
      ),
      SigninPage(),
      SettingPage(),
    ];

    return Scaffold(
      appBar: TopBar(titlePage: titleText[_activepage]),
      body: pages[_activepage],
      floatingActionButton: user.isAdmin && _activepage != 2 && _activepage != 3
          ? AddEventButton(addEvent: _addEvent)
          : null,
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
      unselectedItemColor: const Color(0xFF7B8284),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: 24,
      selectedFontSize: 15,
      enableFeedback: true,
      items: [
        _item(Icons.calendar_month, "Calendario"),
        _item(Icons.event_note, "Eventi"),
        _item(Icons.account_circle_rounded, "Account"),
        //Only development thing
        _item(Icons.settings, "Setting"),
      ],
      currentIndex: _activepage,
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _item(IconData icon, String data) {
    return BottomNavigationBarItem(icon: Icon(icon), label: data);
  }

  void _editEvent(Event updatedEvent) {
    setState(() {
      final index = events.indexWhere((e) => e.id == updatedEvent.id);
      if (index != -1) {
        events[index] = updatedEvent;
        events = _sortEvents();
      }
    });
  }

  void _addEvent(Event newEvent) {
    setState(() {
      events.add(newEvent);
      events = _sortEvents();
    });
  }

  void _deleteEvent(Event deletedEvent) {
    setState(() {
      events.remove(deletedEvent);
    });
  }

  List<Event> _sortEvents() {
    final sorted = List<Event>.from(events)
      ..sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    final now = DateTime.now();
    final upcoming = sorted.where((e) => e.dateEvent.isAfter(now)).toList();
    final past = sorted.where((e) => !e.dateEvent.isAfter(now)).toList();

    return [...upcoming, ...past];
  }
}
