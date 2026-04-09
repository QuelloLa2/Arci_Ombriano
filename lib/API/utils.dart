import 'package:arci_ombriano/Utils/storage.dart';

Future<Map<String, String>> getHeaders() async {
  final token = await storage.read(key: 'token');

  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };
}

const String url = 'http://10.0.0.2:8080';
