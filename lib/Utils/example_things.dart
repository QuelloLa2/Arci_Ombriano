import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/user.dart';

int exampleId = 5;

String exampleText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend, leo sed commodo dignissim, arcu elit egestas magna, vel vestibulum ligula velit et dolor. Mauris placerat eget enim eu pulvinar. Fusce condimentum maximus neque vel ullamcorper. Proin tellus augue, aliquam scelerisque tellus eu, facilisis pulvinar leo. Nunc consectetur velit eu ultrices pretium. Nunc tempus eu velit pretium pellentesque. Vestibulum condimentum ultricies enim, vel aliquam lacus malesuada at. Nam posuere, tortor non sed";

Map<String, Map<String, int>> exampleMapVolunteers = {};

List<Event> exampleEvents = [
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
  Event(
    id: 5,
    nameEvent: "Allenamento",
    timeEvent: DateTime(2026, 6, 28, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
  Event(
    id: 6,
    nameEvent: "Ballo di gruppo",
    timeEvent: DateTime(2026, 5, 28, 19, 0),
    description: exampleText,
    mapVolunteers: exampleMapVolunteers,
  ),
];

User user = User(
  name: "user",
  surname: "user",
  isAdmin: true,
  eMail: "nonlaso@quellola.com",
);

List<String> volunteersWork = [
  "VolontarioOspedale",
  "EducatoreBambini",
  "AssistenteCase",
  "VolontarioCanile",
  "RaccoglitoreCibo",
  "AnimatoreRicreativo",
  "SupportoDisabili",
  "MissionarioUmanitario",
  "TutorStudenti",
  "Ambientalista",
  "AiutoRifugio",
  "BibliotecarioVolontario",
  "AntiViolenza",
  "Soccorritore",
  "Fundraiser",
  "AiutoMigranti",
  "OrganizzatoreEventi",
  "VolontarioGiovani",
  "VolontarioCultura",
  "VolontarioSanitario",
];
