import 'package:arci_ombriano/Event/info_page.dart';
import 'package:arci_ombriano/Admin/mod_event.dart';
import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/role.dart';
import 'package:arci_ombriano/API/event.dart' as api;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    required this.index,
    required this.event,
    required this.primary,
    required this.isAdmin,
    required this.modifyEvent,
    required this.deleteEvent,
  });

  final int index;
  final Event event;
  final Color primary;
  final Function(Event) modifyEvent;
  final Function(Event) deleteEvent;
  final bool isAdmin;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool _isLoading = false;

  Role? get _myRole => widget.event.mapVolunteers.keys.cast<Role?>().firstWhere(
    (r) => r?.id == widget.event.selectedRole,
    orElse: () => null,
  );

  @override
  void didUpdateWidget(covariant EventWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    String timeString = DateFormat("HH:mm").format(event.timeEvent);

    return InkWell(
      enableFeedback: false,
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(
              MaterialPageRoute(builder: (_) => InformationPage(event: event)),
            )
            .then((updatedEvent) {
              if (updatedEvent is Event) {
                widget.modifyEvent(updatedEvent);
              }
            });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 3),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border.all(color: const Color(0x68232120), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Event
            Row(
              children: [
                Text(
                  event.nameEvent,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Expanded(child: SizedBox()),
                widget.isAdmin ? _editButton() : SizedBox(),
                const SizedBox(width: 10),
              ],
            ),

            // Description
            Text(
              event.description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            // Volunteers — tap diretto per iscriversi
            Wrap(
              spacing: 5,
              children: event.mapVolunteers.keys
                  .map((role) => _roleButton(role))
                  .toList(),
            ),

            // Time
            Row(
              children: [
                const SizedBox(width: 2),
                Icon(Icons.access_time, size: 20, color: Color(0xFF000000)),
                const SizedBox(width: 8),
                Text(
                  timeString,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Expanded(child: SizedBox()),
                // Spinner durante il caricamento
                if (_isLoading)
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(Role role) {
    final bool isMyRole = _myRole?.id == role.id;
    final counts = widget.event.mapVolunteers[role];
    final bool isFull =
        !isMyRole &&
        (counts != null && (counts['Current'] ?? 0) >= (counts['Max'] ?? 0));

    return TextButton(
      onPressed: _isLoading
          ? null
          : () {
              if (isMyRole) {
                _disiscrivi();
              } else if (!isFull) {
                _iscriviti(role);
              }
            },
      style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icona: check se iscritto, cerchio pieno off se pieno, radio altrimenti
          isMyRole
              ? Icon(Icons.check_circle, size: 24, color: widget.primary)
              : isFull
              ? Icon(
                  Icons.radio_button_off_outlined,
                  size: 24,
                  color: Colors.grey,
                )
              : Icon(
                  Icons.radio_button_off_outlined,
                  size: 24,
                  color: Colors.black,
                ),
          const SizedBox(width: 3),
          Text(
            role.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isFull && !isMyRole ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _iscriviti(Role role) async {
    if (widget.event.id == null) return;
    setState(() => _isLoading = true);

    final (success, error) = await api.partecipate(widget.event.id!, role.name);

    setState(() => _isLoading = false);

    if (success) {
      widget.modifyEvent(widget.event.copyWith(selectedRole: role.id));
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Iscritto come ${role.name}!')));
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
    if (widget.event.id == null) return;
    setState(() => _isLoading = true);

    final (success, error) = await api.disiscrivi(widget.event.id!);

    setState(() => _isLoading = false);

    if (success) {
      widget.modifyEvent(widget.event.copyWith(clearSelectedRole: true));
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Disiscritto con successo')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Errore durante la disiscrizione')),
        );
      }
    }
  }

  Widget _editButton() {
    Color mainColor = Theme.of(context).colorScheme.primary;

    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: mainColor,
        shape: CircleBorder(),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .push(
              MaterialPageRoute(
                builder: (_) =>
                    ModEvent(event: widget.event, pageName: "Modifica Evento"),
              ),
            )
            .then((result) {
              if (result != null) {
                if (!result['delete'] && result['event'] != null) {
                  widget.modifyEvent(result['event']);
                }
                if (result['delete'] && result['event'] != null) {
                  widget.deleteEvent(result['event']);
                }
              }
            });
      },
      icon: Icon(Icons.mode_edit_outline_rounded, color: Colors.white),
    );
  }
}
