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
import 'package:arci_ombriano/API/event.dart' as api;
import 'package:arci_ombriano/Utils/user.dart';
import 'package:arci_ombriano/Utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('it_IT', null);
  runApp(const MyApp());
}

enum AuthState { loading, authenticated, unauthenticated }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arci Ombriano',
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
  AuthState _authState = AuthState.loading;
  late User _user;
  List<Event> _events = [];
  late int _activePage;
  bool _eventsLoading = true;

  final List<String> _titleText = ["Calendario", "Eventi", "Setting"];

  @override
  void initState() {
    super.initState();
    _activePage = 1;
    _checkAuthAndLoad();
  }

  Future<void> _checkAuthAndLoad() async {
    final token = await storage.read(key: 'token');
    final userId = await storage.read(key: 'user_id');
    final userName = await storage.read(key: 'user_name');
    final isAdmin = await storage.read(key: 'is_admin');

    if (token != null && userId != null && userName != null) {
      _user = User(
        id: int.parse(userId),
        name: userName,
        isAdmin: isAdmin == 'true',
        token: token,
      );
      await _loadEvents();
      setState(() {
        _authState = AuthState.authenticated;
        _eventsLoading = false;
      });
    } else {
      setState(() => _authState = AuthState.unauthenticated);
    }
  }

  Future<void> _loadEvents() async {
    final (fetchedEvents, success) = await api.getEvent();
    if (success && fetchedEvents != null) {
      setState(() {
        _events = _sortEvents(fetchedEvents);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_authState) {
      AuthState.loading => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      AuthState.unauthenticated => SigninPage(onLoginSuccess: _onLoginSuccess),
      AuthState.authenticated =>
        _eventsLoading
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : _buildMainScaffold(),
    };
  }

  void _onLoginSuccess(User user) {
    setState(() {
      _user = user;
      _authState = AuthState.authenticated;
      _eventsLoading = true;
      _activePage = 1;
    });
    _loadEvents().then((_) => setState(() => _eventsLoading = false));
  }

  Widget _buildMainScaffold() {
    final pages = [
      CalendarPage(listEvents: _events),
      EventPage(
        listEvents: _events,
        onRefresh: () => _loadEvents(),
        isAdmin: _user.isAdmin,
        modifyEvent: _editEvent,
        addEvent: _addEvent,
        deleteEvent: _deleteEvent,
      ),
      SettingPage(user: _user),
    ];

    return Scaffold(
      appBar: TopBar(titlePage: _titleText[_activePage]),
      body: pages[_activePage],
      floatingActionButton: _user.isAdmin && _activePage != 2
          ? AddEventButton(addEvent: _addEvent)
          : null,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: const Color(0xFF7B8284),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: 24,
      selectedFontSize: 15,
      enableFeedback: true,
      items: [
        _navItem(Icons.calendar_month, "Calendario"),
        _navItem(Icons.event_note, "Eventi"),
        _navItem(Icons.settings, "Setting"),
      ],
      currentIndex: _activePage,
      onTap: (index) => setState(() => _activePage = index),
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  void _editEvent(Event updatedEvent) {
    setState(() {
      final index = _events.indexWhere((e) => e.id == updatedEvent.id);
      if (index != -1) {
        _events[index] = updatedEvent;
        _events = _sortEvents(_events);
      }
    });
  }

  void _addEvent(Event newEvent) {
    setState(() {
      _events.add(newEvent);
      _events = _sortEvents(_events);
    });
  }

  void _deleteEvent(Event deletedEvent) {
    setState(() => _events.remove(deletedEvent));
  }

  List<Event> _sortEvents(List<Event> events) {
    final sorted = List<Event>.from(events)
      ..sort((a, b) => a.timeEvent.compareTo(b.timeEvent));

    final now = DateTime.now();
    final upcoming = sorted.where((e) => e.dateEvent.isAfter(now)).toList();
    final past = sorted.where((e) => !e.dateEvent.isAfter(now)).toList();

    return [...upcoming, ...past];
  }
}
