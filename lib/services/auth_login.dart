import 'package:http/http.dart' as http;

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
  // static String? sessionCookie; // Store the session cookie

  // static Future<String> sendOTP(String mobileNumber) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://service.codingbandar.com/Api/login'));
  //   request.fields.addAll({
  //     'mobile': mobileNumber,
  //   });

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     // Extract and store the session cookie
  //     sessionCookie = response.headers['set-cookie'];
  //     print(sessionCookie);

  //     return await response.stream.bytesToString();
  //   } else {
  //     throw Exception(
  //         'Failed to send OTP. Status code: ${response.statusCode}');
  //   }
  // }
  static Future<String> verifyOTP(String mobileNumber, String otp) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/verify_otp'),
        body: {'mobile': mobileNumber, 'otp': otp},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
            'Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
  // static Future<String> verifyOTP(String mobileNumber, String otp) async {
  //   // Convert headers to Map<String, String>
  //   Map<String, String> headers = {
  //     'Cookie': sessionCookie ?? '',
  //   };

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://service.codingbandar.com/Api/verify_otp'),
  //   );

  //   request.fields.addAll({
  //     'mobile': mobileNumber,
  //     'otp': otp,
  //   });

  //   request.headers.addAll(headers);

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     return await response.stream.bytesToString();
  //   } else {
  //     throw Exception(
  //       'Failed to verify OTP. Status code: ${response.statusCode}',
  //     );
  //   }
  // }
}
