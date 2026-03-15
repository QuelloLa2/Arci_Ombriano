import 'package:arci_ombriano/Utils/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "http://localhost:8080/events";

void addEvent(Event event) async {
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZW1iZXJfaWQiOjEsInNob3duYW1lIjoiVXNlciIsImlzX2FkbWluIjpmYWxzZSwiZXhwIjoxNzc2MTY0NTA1LCJpYXQiOjE3NzM1NzI1MDV9.xfnU8ArwgC2Y6njdWdPSvbmzDKAjRFt7jX4a6lPkXcY';

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'name': event.nameEvent,
      'description': event.description,
      'date': event.dateEvent.toUtc().toIso8601String(),
      'roles': event.mapVolunteers.entries
          .map((entry) => {'id': entry.key, 'max': entry.value['Max']})
          .toList(),
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print(response.body);
  } else {
    throw Exception(
      'Failed to add event: ${response.statusCode} - ${response.body}',
    );
  }
}
