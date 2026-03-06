import 'package:arci_ombriano/Utils/example_things.dart';
import 'package:flutter/material.dart';

class RoleSelector extends StatefulWidget {
  final Function(List<String>)? selectedRoles;

  const RoleSelector({super.key, required this.selectedRoles});

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  List<String> selectedRoles = [];

  @override
  Widget build(BuildContext context) {
    return roleSelector();
  }

  Widget roleSelector() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(width: 1),
        ),
        elevation: 0,
        child: TextButton(
          onPressed: () async {
            final List<String>? result = await showDialog(
              context: context,
              builder: (context) => _alertSelector(context),
            );
            if (result != null) {
              setState(() {
                selectedRoles = result;
              });
              widget.selectedRoles?.call(selectedRoles);
            }
          },
          child: Text("Seleziona ruoli"),
        ),
      ),
    );
  }

  Widget _alertSelector(BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (context, setStateDialog) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: volunteersWork.map((role) {
                return CheckboxListTile(
                  value: selectedRoles.contains(role),
                  title: Text(role),
                  onChanged: (value) {
                    setStateDialog(() {
                      if (value == true) {
                        selectedRoles.add(role);
                      } else {
                        selectedRoles.remove(role);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Esci", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedRoles);
          },
          child: Text("Conferma", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
