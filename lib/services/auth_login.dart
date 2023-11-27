import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mpc/data/models/user_model.dart';

class AuthService {
  static final String baseUrl = 'https://service.codingbandar.com/Api';

  static Future<String> sendOTP(String mobileNumber) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {'mobile': mobileNumber},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // }
  static Future<UserModel> verifyOTP(String mobileNumber, String otp) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/verify_otp'),
        body: {'mobile': mobileNumber, 'otp': otp},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response and return a UserModel instance
        var jsonMap = json.decode(response.body);
        return UserModel.fromJson(jsonMap);
      } else {
        throw Exception(
            'Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
