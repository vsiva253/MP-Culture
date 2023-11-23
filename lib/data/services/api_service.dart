import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mpc/data/models/event_model.dart';

class ApiService {
  final String baseUrl;
  final String basicAuth;

  ApiService({
    required this.baseUrl,
    required this.basicAuth,
  });

  // program api

  Future<List<EventData>> getTodayPrograms(String endPoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endPoint'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => EventData.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load today\'s programs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching today\'s programs: $e');
    }
  }
  // about api

  Future<String> getAboutUsContent() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/aboutus'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData['about_us'];
      } else {
        throw Exception(
            'Failed to fetch about us content. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching about us content: $e');
    }
  }
}
