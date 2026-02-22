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

  @override
  String toString() => nameEvent;
}
