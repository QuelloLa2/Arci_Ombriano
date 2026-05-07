import 'package:arci_ombriano/Utils/event.dart';
import 'package:arci_ombriano/Utils/role.dart';
import 'package:http/http.dart' as http;
import 'package:arci_ombriano/API/utils.dart' as info;
import 'dart:convert';

typedef RoleMap = Map<Role, Map<String, int>>;

void addEvent(Event event) async {
  final response = await http.post(
    Uri.parse('${info.url}/events'),
    headers: await info.getHeaders(),
    body: jsonEncode({
      'name': event.nameEvent,
      'description': event.description,
      'date': event.timeEvent.toUtc().toIso8601String(),
      'roles': event.mapVolunteers.entries
          .map((entry) => {'id': entry.key.id, 'max': entry.value['Max']})
          .toList(),
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    assert(() {
      print(response.body);
      return true;
    }());
  } else {
    throw Exception(
      'Failed to add event: ${response.statusCode} - ${response.body}',
    );
  }
}

Future<(List<Event>?, bool)> getEvent() async {
  final response = await http.get(
    Uri.parse('${info.url}/events'),
    headers: await info.getHeaders(),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var events = data['events'] as List<dynamic>;

    List<Event> listEvents = [];

    for (var event in events) {
      RoleMap listRole = {};
      var roles = event['roles'] as List<dynamic>;

      for (var role in roles) {
        RoleMap newRole = {
          Role(id: role['id'], name: role['name']): {
            "Current": 0,
            "Max": role['max'],
          },
        };
        listRole.addEntries(newRole.entries);
      }

      Map<String, List<String>> volunteersMap = {};
      if (event['volunteers'] != null) {
        final raw = event['volunteers'] as Map<String, dynamic>;
        raw.forEach((roleName, list) {
          volunteersMap[roleName] = (list as List<dynamic>)
              .map((v) => v['name'].toString())
              .toList();
        });
        for (var role in listRole.keys) {
          final count = volunteersMap[role.name]?.length ?? 0;
          listRole[role]!['Current'] = count;
        }
      }

      int? selectedRole;
      if (event['selected-role'] != null) {
        selectedRole = int.tryParse(event['selected-role'].toString());
      }

      listEvents.add(
        Event(
          id: int.parse(event['id'].toString()),
          nameEvent: event['titolo'],
          timeEvent: DateTime.parse(event['data']).toLocal(),
          description: event['descrizione'],
          mapVolunteers: listRole,
          selectedRole: selectedRole,
          volunteers: volunteersMap,
        ),
      );
    }
    return (listEvents, true);
  }

  print('Failed to get events: ${response.statusCode} - ${response.body}');
  return (null, false);
}

Future<(bool, String?)> partecipate(int eventId, String roleName) async {
  final response = await http.post(
    Uri.parse('${info.url}/events/$eventId/partecipate'),
    headers: await info.getHeaders(),
    body: jsonEncode({'role': roleName}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return (true, null);
  }

  String errorMsg = 'Errore durante l\'iscrizione';
  try {
    final body = jsonDecode(response.body);
    if (body['error'] != null) errorMsg = body['error'].toString();
  } catch (_) {}

  if (response.statusCode == 400) {
    return (false, errorMsg);
  }
  return (false, errorMsg);
}

Future<(bool, String?)> disiscrivi(int eventId) async {
  final response = await http.delete(
    Uri.parse('${info.url}/events/$eventId/partecipate'),
    headers: await info.getHeaders(),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return (true, null);
  }

  if (response.statusCode == 404) {
    return (false, 'Non risulti iscritto a questo evento');
  }

  return (false, 'Errore durante la disiscrizione');
}

