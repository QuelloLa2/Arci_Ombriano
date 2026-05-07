import 'package:http/http.dart' as http;
import 'package:arci_ombriano/API/utils.dart' as info;
import 'package:arci_ombriano/Utils/user.dart';
import 'dart:convert';

Future<(User?, bool)> logIn(String email) async {
  final response = await http.post(
    Uri.parse('${info.url}/login'),
    headers: await info.getHeaders(),
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    assert(() {
      print(response.body);
      return true;
    }());

    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var member = data['member'] as Map<String, dynamic>;

    User newLogin = User(
      id: member['id'],
      name: member['showname'],
      isAdmin: member['is_admin'],
      token: data['token'],
    );

    return (newLogin, true);
  } else {
    print('Failed to login: ${response.statusCode} - ${response.body}');
  }

  return (null, false);
}

Future<(User?, bool)> register(String email, String name) async {
  final response = await http.post(
    Uri.parse('${info.url}/register'),
    headers: await info.getHeaders(),
    body: jsonEncode({'email': email, 'name': name}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    assert(() {
      print(response.body);
      return true;
    }());

    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var member = data['member'] as Map<String, dynamic>;

    User newUser = User(
      id: member['id'],
      name: member['showname'],
      isAdmin: member['is_admin'],
      token: data['token'],
    );

    return (newUser, true);
  } else {
    print('Failed to register: ${response.statusCode} - ${response.body}');
  }

  return (null, false);
}

