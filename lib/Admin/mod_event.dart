import 'package:arci_ombriano/Admin/mod_widget/input_widget.dart';
import 'package:arci_ombriano/Admin/mod_widget/button_widget.dart';
import 'package:arci_ombriano/Admin/mod_widget/selector_widget.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModEvent extends StatefulWidget {
  const ModEvent({super.key, this.event});

  final Event? event;
  @override
  State<ModEvent> createState() => _ModEventState();
}

class _ModEventState extends State<ModEvent> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;

  DateFormat stdDate = DateFormat('dd/MM/yyyy');
  DateFormat stdTime = DateFormat('HH:mm');
  DateFormat stdDateTime = DateFormat('dd-MM-yyyy HH:mm');

  List<String> selectedRoles = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.event?.nameEvent ?? '',
    );
    _descController = TextEditingController(
      text: widget.event?.description ?? '',
    );
    _dateController = TextEditingController(
      text: stdDate.format(widget.event?.dateEvent ?? DateTime.now()),
    );
    _timeController = TextEditingController(
      text: stdTime.format(widget.event?.timeEvent ?? DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottom(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 32,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Creazione Evento",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputField("Titolo", _titleController),
            SizedBox(height: 25),
            descField("Descrizione", _descController),
            SizedBox(height: 25),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: dateField(
                    "Data",
                    _dateController,
                    stdDate,
                    context,
                    widget.event,
                  ),
                ),
                Expanded(
                  child: timeField(
                    "Ora",
                    _timeController,
                    stdTime,
                    context,
                    widget.event,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            RoleSelector(
              selectedRoles: (roles) => {
                setState(() {
                  selectedRoles = roles;
                }),
              },
            ),
            SizedBox(height: 25),
            SizedBox(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      ...selectedRoles.map((role) => _selectedRoles(role)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedRoles(String role) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedRoles.remove(role);
            });
          },
          child: SizedBox(
            child: Text(role, style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _bottom() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 7,
        children: [
          deleteButton(context, widget.event),
          confermButton(
            context,
            widget.event,
            _titleController,
            _descController,
            _dateController,
            _timeController,
            stdDate,
            stdTime,
          ),
        ],
      ),
    );
  }
}
