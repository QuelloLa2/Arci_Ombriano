class Event {
  final int id;
  String nameEvent;
  DateTime dateEvent; // dd/mm/yy
  DateTime timeEvent; // dd/mm/yy hh:mm
  String description;
  Map<String, Map<String, int>> mapVolunteers;

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
