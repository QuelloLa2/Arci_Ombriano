String _token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZW1iZXJfaWQiOjEsInNob3duYW1lIjoiVXNlciIsImlzX2FkbWluIjp0cnVlLCJleHAiOjE3NzY3MTI5NzYsImlhdCI6MTc3NDEyMDk3Nn0.R0p_bi_s63smsnitUZUMY_jgTj-PJ8nY_SDL5C1LhMQ';

Map<String, String> header = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $_token',
};

String url = 'http://10.0.0.2:8080/';
