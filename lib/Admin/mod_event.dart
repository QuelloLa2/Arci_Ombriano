import 'package:arci_ombriano/Admin/mod_widget/input_widget.dart';
import 'package:arci_ombriano/Admin/mod_widget/button_widget.dart';
import 'package:arci_ombriano/Admin/mod_widget/selector_widget.dart';
import 'package:arci_ombriano/API/roles.dart' as api;
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ModEvent extends StatefulWidget {
  const ModEvent({super.key, this.event, required this.pageName});

  final Event? event;
  final String pageName;

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
  Map<Role, TextEditingController> selectedRoles = {};

  Map<int, String> roleNames = {};

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

    Map<Role, Map<String, int>>? volunteers = widget.event?.mapVolunteers;

    if (volunteers != null) {
      selectedRoles = Map.fromEntries(
        volunteers.entries.map(
          (role) => MapEntry(
            role.key,
            TextEditingController(text: role.value.values.last.toString()),
          ),
        ),
      );
      for (final role in volunteers.keys) {
        roleNames[role.id] = role.name;
      }
    }

    _loadRoleNames();
  }

  Future<void> _loadRoleNames() async {
    final roles = await api.getRoles();
    setState(() {
      for (final role in roles) {
        roleNames[role.id] = role.name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
    for (final controller in selectedRoles.values) {
      controller.dispose();
    }
    super.dispose();
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.keyboard_arrow_left_rounded,
          size: 32,
          color: Color(0xFF171717),
        ),
      ),
      title: Text(
        widget.pageName,
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
              selectedRoles: (roles) {
                setState(() {
                  selectedRoles = roles;
                });
              },
              selectionRoles: selectedRoles,
            ),
            SizedBox(height: 25),
            Column(
              children: [
                ...selectedRoles.entries.map(
                  (entry) => _selectedRoles(entry.key.id, entry.value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedRoles(int roleId, TextEditingController controller) {
    final roleName = roleNames[roleId] ?? roleId.toString();

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 7.5),
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 10),
                Text(roleName, style: TextStyle(fontSize: 16)),
                Expanded(child: SizedBox()),
                SizedBox(
                  width: 30,
                  child: TextField(
                    controller: controller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.5),
                IconButton(
                  onPressed: () {
                    setState(() {
                      final roleKey = selectedRoles.keys.firstWhere(
                        (role) => role.id == roleId,
                      );
                      selectedRoles.remove(roleKey);
                    });
                  },
                  icon: Icon(Icons.person_remove, color: Colors.black),
                ),
              ],
            ),
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
            selectedRoles,
            stdDate,
            stdTime,
          ),
        ],
      ),
    );
  }
}
