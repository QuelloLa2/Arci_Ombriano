import 'package:flutter/material.dart';
import 'package:arci_ombriano/API/roles.dart' as api;
import 'package:arci_ombriano/Utils/user.dart';
import 'package:arci_ombriano/Utils/role.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.user, required this.onLogout});
  final User user;
  final VoidCallback onLogout;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _userCard(),
          const SizedBox(height: 16),
          _logoutButton(),
          const SizedBox(height: 24),
          if (widget.user.isAdmin) _adminRole(),
        ],
      ),
    );
  }

  Widget _userCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_rounded,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Utente",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7B8284),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.user.isAdmin)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF171717),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () => widget.onLogout(),
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: const Text("Esci"),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error,
          side: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _adminRole() {
    return Card(
      child: ExpansionTile(
        leading: Icon(
          Icons.group_rounded,
          size: 28,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text(
          "Ruoli",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _singleRole(String data) {
    return ListTile(
      leading: Icon(
        Icons.person_rounded,
        size: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        data,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _addRole() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Aggiungi Ruolo",
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              controller: roleController,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
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
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
