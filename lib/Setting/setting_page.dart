import 'package:flutter/material.dart';
import 'package:arci_ombriano/API/roles.dart' as api;
import 'package:arci_ombriano/Utils/role.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Role> listRoles = [];
  bool isLoading = true;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    _loadRoles();
    roleController = TextEditingController();
  }

  Future<void> _loadRoles() async {
    final roles = await api.getRoles();
    setState(() {
      listRoles = roles;
      listRoles.sort((a, b) => a.name.compareTo(b.name));
      isLoading = false;
    });
  }

  @override
  void dispose() {
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black, width: 2),
            ),
            child: ExpansionTile(
              shape: LinearBorder.none,
              collapsedShape: LinearBorder.none,
              leading: Icon(Icons.group, size: 30),
              title: Text(
                "Ruoli",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 175,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...listRoles.map((item) => _singleRole(item.name)),
                      ],
                    ),
                  ),
                ),
                _addRole(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleRole(String data) {
    return ListTile(
      leading: Icon(Icons.person, size: 28),
      title: Text(
        data,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _addRole() {
    return ListTile(
      leading: Icon(Icons.person_add),
      title: TextField(
        decoration: InputDecoration(labelText: "Aggiungi Ruolo"),
        controller: roleController,
      ),
      trailing: IconButton(
        onPressed: () async {
          final (newRole, check) = await api.addRole(roleController.text);
          if (check) listRoles.add(newRole!);
          setState(() {
            roleController.text = '';
          });
        },
        icon: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
