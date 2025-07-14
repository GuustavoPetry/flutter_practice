import "dart:convert";

import "package:http/http.dart" as http;

class ApiService {
  final _baseUrl = "https://api-petry.onrender.com";

  Future<String?> login(Map<String, dynamic> data) async {
    final url = Uri.parse("$_baseUrl/login"); // parse do URL, recomendado sempre fazer

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data)
    );

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["token"];
    } else {
      return null;
    }
  }
}