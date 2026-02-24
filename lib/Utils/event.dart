class Event {
  final int id;
  String nameEvent;
  DateTime dateEvent;
  DateTime timeEvent;
  String description;
  final Map<String, Map<String, int>> mapVolunteers;

  Event({
    required this.id,
    required this.nameEvent,
    required this.timeEvent,
    required this.description,
    required this.mapVolunteers,
  }) : dateEvent = DateTime(timeEvent.year, timeEvent.month, timeEvent.day);

  Event copyWith({
    String? nameEvent,
    DateTime? timeEvent,
    String? description,
    Map<String, Map<String, int>>? mapVolunteers,
  }) {
    return Event(
      id: id,
      nameEvent: nameEvent ?? this.nameEvent,
      timeEvent: timeEvent ?? this.timeEvent,
      description: description ?? this.description,
      mapVolunteers: mapVolunteers ?? this.mapVolunteers,
    );
  }

  @override
  String toString() => nameEvent;
}
