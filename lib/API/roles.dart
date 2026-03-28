import 'package:http/http.dart' as http;
import 'package:arci_ombriano/API/utils.dart' as info;
import 'package:arci_ombriano/Utils/role.dart';
import 'dart:convert';

Future<List<Role>> getRoles() async {
  final response = await http.get(
    Uri.parse('${info.url}roles'),
    headers: info.header,
  );

  List<Role> listRoles = [];

  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var roles = data['roles'] as List<dynamic>;

    for (var item in roles) {
      Role role = Role(
        id: int.parse(item['id'].toString()),
        name: item['name'].toString(),
      );

      listRoles.add(role);
    }
  }

  return listRoles;
}

Future<(Role?, bool)> addRole(String name) async {
  final response = await http.post(
    Uri.parse('${info.url}roles'),
    headers: info.header,
    body: jsonEncode({"name": name}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var role = data['role'] as Map<String, dynamic>;

    Role newRole = Role(
      id: int.parse(role['id'].toString()),
      name: role['name'].toString(),
    );
    return (newRole, true);
  }

  return (null, false);
}
