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
      'date': event.dateEvent.toUtc().toIso8601String(),
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

      listEvents.add(
        Event(
          id: int.parse(event['id'].toString()),
          nameEvent: event['titolo'],
          timeEvent: DateTime.parse(event['data']),
          description: event['descrizione'],
          mapVolunteers: listRole,
        ),
      );
    }
    return (listEvents, true);
  }

  return (null, false);
}
