import 'package:arci_ombriano/Appbar/menu.dart';
import 'package:arci_ombriano/Eventi/event_page.dart';
import 'package:arci_ombriano/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:arci_ombriano/Appbar/appbar.dart';

void main() {
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
  bool _menulist = false;

  Widget main = EventPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(onPressed: menuListState),
      body: Stack(children: [EventPage(), if (_menulist) MenuAppBar()]),
    );
  }

  void menuListState() {
    setState(() {
      _menulist = !_menulist;
    });
  }
}
