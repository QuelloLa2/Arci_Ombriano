import 'package:arci_ombriano/API/roles.dart' as api;
import 'package:arci_ombriano/Utils/role.dart';
import 'package:flutter/material.dart';

class RoleSelector extends StatefulWidget {
  const RoleSelector({
    super.key,
    required this.selectedRoles,
    required this.selectionRoles,
  });

  final Function(Map<Role, TextEditingController>)? selectedRoles;
  final Map<Role, TextEditingController> selectionRoles;

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  late Map<Role, TextEditingController> selectedRoles = {};
  List<Role> listRoles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedRoles = Map.from(widget.selectionRoles);
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    final roles = await api.getRoles();
    setState(() {
      listRoles = roles..sort((a, b) => a.name.compareTo(b.name));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return roleSelector();
  }

  @override
  void dispose() {
    super.dispose();
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
          onPressed: isLoading
              ? null
              : () async {
                  final Map<Role, TextEditingController>? result =
                      await showDialog(
                        context: context,
                        builder: (context) =>
                            _alertSelector(context, Map.from(selectedRoles)),
                      );
                  if (result != null) {
                    setState(() {
                      selectedRoles = result;
                    });
                    widget.selectedRoles?.call(selectedRoles);
                  }
                },
          child: isLoading
              ? SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text("Seleziona ruoli"),
        ),
      ),
    );
  }

  Widget _alertSelector(
    BuildContext context,
    Map<Role, TextEditingController> tempSelected,
  ) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (context, setStateDialog) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: listRoles.map((role) {
                return CheckboxListTile(
                  value: tempSelected.containsKey(role),
                  title: Text(role.name),
                  onChanged: (value) {
                    setStateDialog(() {
                      if (value == true) {
                        tempSelected[role] = TextEditingController(text: '1');
                      } else {
                        tempSelected.remove(role);
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
          onPressed: () => Navigator.pop(context),
          child: Text("Esci", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, tempSelected),
          child: Text("Conferma", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
