import 'package:flutter/material.dart';
import 'package:arci_ombriano/API/roles.dart' as api;
import 'package:arci_ombriano/Utils/user.dart';
import 'package:arci_ombriano/Utils/role.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.user});
  final User user;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Role> listRoles = [];
  bool isLoading = false;
  TextEditingController? roleController;

  @override
  void initState() {
    super.initState();
    if (widget.user.isAdmin) {
      roleController = TextEditingController();
      _loadRoles();
    }
  }

  Future<void> _loadRoles() async {
    setState(() => isLoading = true);
    final roles = await api.getRoles();
    setState(() {
      listRoles = roles..sort((a, b) => a.name.compareTo(b.name));
      isLoading = false;
    });
  }

  @override
  void dispose() {
    roleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Nome: ${widget.user.name}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
          ),
          widget.user.isAdmin ? _adminRole() : const SizedBox(),
        ],
      ),
    );
  }

  Widget _adminRole() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      child: ExpansionTile(
        shape: LinearBorder.none,
        collapsedShape: LinearBorder.none,
        leading: const Icon(Icons.group, size: 30),
        title: const Text(
          "Ruoli",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2 - 175,
            child: SingleChildScrollView(
              child: Column(
                children: listRoles
                    .map((item) => _singleRole(item.name))
                    .toList(),
              ),
            ),
          ),
          _addRole(),
        ],
      ),
    );
  }

  Widget _singleRole(String data) {
    return ListTile(
      leading: const Icon(Icons.person, size: 28),
      title: Text(
        data,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _addRole() {
    return ListTile(
      leading: const Icon(Icons.person_add),
      title: TextField(
        decoration: const InputDecoration(labelText: "Aggiungi Ruolo"),
        controller: roleController,
      ),
      trailing: IconButton(
        onPressed: () async {
          final text = roleController?.text.trim() ?? '';
          if (text.isEmpty) return;

          final (newRole, check) = await api.addRole(text);
          if (check && newRole != null) {
            setState(() {
              listRoles
                ..add(newRole)
                ..sort((a, b) => a.name.compareTo(b.name));
              roleController?.clear();
            });
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
