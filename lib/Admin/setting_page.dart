import 'package:flutter/material.dart';
import 'package:arci_ombriano/Utils/example_things.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    volunteersWork.sort((a, b) => a.compareTo(b));

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
                        ...volunteersWork.map((role) => _singleRole(role)),
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
    final TextEditingController roleController = TextEditingController();

    return ListTile(
      leading: Icon(Icons.person_add),
      title: TextField(
        decoration: InputDecoration(labelText: "Aggiungi Ruolo"),
        controller: roleController,
      ),
      trailing: IconButton(
        onPressed: () {
          volunteersWork.add(roleController.text);
          setState(() {
            roleController.text = '';
          });
        },
        icon: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
