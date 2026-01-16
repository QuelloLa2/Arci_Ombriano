class Event {
  final String nameEvent;
  final DateTime dateEvent;
  final String description;
  final Map<String, Map<String, int>> mapVolunteers;

  const Event(
    this.nameEvent,
    this.dateEvent,
    this.description,
    this.mapVolunteers,
  );
}
