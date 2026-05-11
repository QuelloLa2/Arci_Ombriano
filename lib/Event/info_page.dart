import 'package:arci_ombriano/Utils/role.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/API/event.dart' as api;
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  final Event event;
  final String currentUserName;

  const InformationPage({
    super.key,
    required this.event,
    required this.currentUserName,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  bool _isLoading = false;
  late Event _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  Role? get _myRole => _event.mapVolunteers.keys.cast<Role?>().firstWhere(
    (r) => r?.id == _event.selectedRole,
    orElse: () => null,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, _event),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          _event.nameEvent,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _description(_event.description),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.group_rounded,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text(
                "Volontariato",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._event.mapVolunteers.entries.map(
                    (work) => _roleCard(
                      work.key,
                      work.value['Current'] ?? 0,
                      work.value['Max'] ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(String data) {
    return Text(
      data,
      style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF555555)),
    );
  }

  Widget _roleCard(Role role, int nVolunteer, int maxVolunteer) {
    final List<String> names = _event.volunteers[role.name] ?? [];
    final bool isMyRole = _myRole?.id == role.id;
    final bool isFull = maxVolunteer > 0 && nVolunteer >= maxVolunteer;

    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.badge_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      role.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _actionButton(role, isMyRole, isFull),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$nVolunteer/$maxVolunteer",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              if (names.isNotEmpty) ...[
                const SizedBox(height: 10),
                Divider(height: 1, color: Colors.grey.shade200),
                const SizedBox(height: 8),
                ...names.map(
                  (name) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(name, style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(Role role, bool isMyRole, bool isFull) {
    final primary = Theme.of(context).colorScheme.primary;

    if (isMyRole) {
      return OutlinedButton.icon(
        onPressed: _isLoading ? null : _disiscrivi,
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.logout_rounded, size: 18),
        label: const Text("Cancella"),
      );
    }

    if (isFull) {
      return OutlinedButton.icon(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.block_rounded, size: 18),
        label: const Text("Completo"),
      );
    }

    return ElevatedButton.icon(
      onPressed: _isLoading ? null : () => _iscriviti(role),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.person_add_rounded, size: 18),
      label: const Text("Offriti"),
    );
  }

  Future<void> _iscriviti(Role role) async {
    if (_event.id == null) return;

    final counts = _event.mapVolunteers[role];
    final max = counts?['Max'] ?? 0;
    final current = counts?['Current'] ?? 0;
    final bool isFull = max > 0 && current >= max;
    if (counts == null || isFull) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ruolo completo")),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    final (success, error) = await api.partecipate(_event.id!, role.name);

    setState(() => _isLoading = false);

    if (success) {
      setState(() {
        final updatedVolunteers = Map<Role, Map<String, int>>.from(_event.mapVolunteers);
        final updatedVolNames = Map<String, List<String>>.from(_event.volunteers);

        if (_myRole != null) {
          updatedVolunteers[_myRole!] = {
            'Current': (updatedVolunteers[_myRole]!['Current'] ?? 0) - 1,
            'Max': updatedVolunteers[_myRole]!['Max'] ?? 0,
          };
          updatedVolNames[_myRole!.name] = (updatedVolNames[_myRole!.name] ?? [])
              .where((n) => n != widget.currentUserName)
              .toList();
        }

        updatedVolunteers[role] = {
          'Current': (updatedVolunteers[role]!['Current'] ?? 0) + 1,
          'Max': updatedVolunteers[role]!['Max'] ?? 0,
        };
        updatedVolNames[role.name] = [...(updatedVolNames[role.name] ?? []), widget.currentUserName];

        _event = _event.copyWith(
          selectedRole: role.id,
          mapVolunteers: updatedVolunteers,
          volunteers: updatedVolNames,
        );
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Iscritto come ${role.name}!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? "Errore durante l'iscrizione")),
        );
      }
    }
  }

  Future<void> _disiscrivi() async {
    if (_event.id == null) return;

    setState(() => _isLoading = true);

    final (success, error) = await api.disiscrivi(_event.id!);

    setState(() => _isLoading = false);

    if (success) {
      setState(() {
        final currentRole = _myRole;
        if (currentRole != null) {
          final updatedVolunteers = Map<Role, Map<String, int>>.from(_event.mapVolunteers);
          updatedVolunteers[currentRole] = {
            'Current': (updatedVolunteers[currentRole]!['Current'] ?? 0) - 1,
            'Max': updatedVolunteers[currentRole]!['Max'] ?? 0,
          };
          final updatedVolNames = Map<String, List<String>>.from(_event.volunteers);
          updatedVolNames[currentRole.name] = (updatedVolNames[currentRole.name] ?? [])
              .where((n) => n != widget.currentUserName)
              .toList();
          _event = _event.copyWith(
            clearSelectedRole: true,
            mapVolunteers: updatedVolunteers,
            volunteers: updatedVolNames,
          );
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Disiscritto con successo')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Errore durante la disiscrizione')),
        );
      }
    }
  }
}
