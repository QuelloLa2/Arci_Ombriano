import 'package:arci_ombriano/Utils/event.dart';

final String exampleText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

final Map<String, Map<String, int>> exampleMapVolunteers = {
  'Cuoco': {'Current': 2, 'Max': 2},
  'Audio': {'Current': 1, 'Max': 3},
  'Cameriere': {'Current': 1, 'Max': 4},
};

final List<Event> exampleEvents = [
  Event(
    id: 0,
    nameEvent: "Riunione",
    timeEvent: DateTime(2026, 1, 14, 21, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
  Event(
    id: 1,
    nameEvent: "Grassi's Night",
    timeEvent: DateTime(2026, 1, 14, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
  Event(
    id: 2,
    nameEvent: "Cinema",
    timeEvent: DateTime(2026, 1, 8, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
  Event(
    id: 3,
    nameEvent: "Convocazione",
    timeEvent: DateTime(2026, 1, 18, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
  Event(
    id: 4,
    nameEvent: "Lezione",
    timeEvent: DateTime(2026, 1, 28, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
];
