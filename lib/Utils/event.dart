import 'package:arci_ombriano/Utils/role.dart';

class Event {
  int? id;
  String nameEvent;
  DateTime dateEvent;
  DateTime timeEvent;
  String description;
  final Map<Role, Map<String, int>> mapVolunteers;
  // ID del ruolo con cui l'utente corrente è iscritto (null = non iscritto)
  int? selectedRole;
  // Lista nomi volontari per ruolo, es: {"Volontario": ["Mario Rossi"]}
  Map<String, List<String>> volunteers;

  Event({
    this.id,
    required this.nameEvent,
    required this.timeEvent,
    required this.description,
    required this.mapVolunteers,
    this.selectedRole,
    Map<String, List<String>>? volunteers,
  }) : dateEvent = DateTime(timeEvent.year, timeEvent.month, timeEvent.day),
       volunteers = volunteers ?? {};

  Event copyWith({
    String? nameEvent,
    DateTime? timeEvent,
    String? description,
    Map<Role, Map<String, int>>? mapVolunteers,
    int? selectedRole,
    bool clearSelectedRole = false,
    Map<String, List<String>>? volunteers,
  }) {
    return Event(
      id: id,
      nameEvent: nameEvent ?? this.nameEvent,
      timeEvent: timeEvent ?? this.timeEvent,
      description: description ?? this.description,
      mapVolunteers: mapVolunteers ?? this.mapVolunteers,
      selectedRole: clearSelectedRole ? null : (selectedRole ?? this.selectedRole),
      volunteers: volunteers ?? this.volunteers,
    );
  }

  // Alias per compatibilità
  String get descEvent => description;

  @override
  String toString() => nameEvent;
}
