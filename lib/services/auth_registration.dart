import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://service.codingbandar.com/Api";

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$baseUrl/signup");

    try {
      final response = await http.post(
        url,
        body: {
          "name": name,
          "email": email,
          "mobile": mobile,
          "password": password,
          "cpassword": confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to register user");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
