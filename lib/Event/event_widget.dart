import 'package:arci_ombriano/Event/info_page.dart';
import 'package:arci_ombriano/Admin/mod_event.dart';
import 'package:arci_ombriano/Utils/event.dart';
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
    required this.currentUserName,
  });

  final int index;
  final Event event;
  final Color primary;
  final Function(Event) modifyEvent;
  final Function(Event) deleteEvent;
  final bool isAdmin;
  final String currentUserName;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  void didUpdateWidget(covariant EventWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    String timeString = DateFormat("HH:mm").format(event.timeEvent);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: const Color(0x30232120), width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(
                  MaterialPageRoute(
                    builder: (_) => InformationPage(event: event, currentUserName: widget.currentUserName),
                  ),
                )
                .then((updatedEvent) {
                  if (updatedEvent is Event) {
                    widget.modifyEvent(updatedEvent);
                  }
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.nameEvent,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.isAdmin) _editButton(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF555555),
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: widget.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editButton() {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: widget.primary.withAlpha(30),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
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
      icon: Icon(Icons.mode_edit_outline_rounded, color: widget.primary, size: 20),
    );
  }
}
