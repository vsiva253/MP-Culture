import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mpc/data/models/academies_model.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/data/models/single_academiec_model.dart';
import 'package:mpc/data/models/single_event_model.dart';
import 'package:mpc/data/models/user_model.dart';

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

  // single program api
  Future<SingleProgram> getSingleProgram(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/single_programme?id=$id'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return SingleProgram.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load Acadmiec Data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Acadmiec Data: $e');
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

  // slider image url api

  Future<List<String>> getSliderImages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/slider'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        List<String> imageUrls = [];
        jsonData.forEach((key, value) {
          imageUrls.add(value.toString());
        });
        return imageUrls;
      } else {
        throw Exception(
            'Failed to load Slider images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Slider images : $e');
    }
  }

  // All category data

  Future<List<CatrgoryModel>> getAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/allcategory'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => CatrgoryModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load Categoery data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Categoery data: $e');
    }
  }

  // acadmic data
  Future<List<DepartmentModel>> getAllAcadmiec() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/all_academies'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => DepartmentModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load Acadmiec Data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Acadmiec Data: $e');
    }
  }

  // single Academiec api
  Future<SingleAacademies> getSingleAcademice(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/single_academies?id=$id'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return SingleAacademies.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load Acadmiec Data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching  Acadmiec Data: $e');
    }
  }

  // // get programs by category

  // Future<List<EventData>> getProgramsByCategory(String categoreyName) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/Api/programs_by_category?program_category=$categoreyName'),
  //       headers: {'Authorization': 'Basic $basicAuth'},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body);
  //       return jsonData.map((json) => EventData.fromJson(json)).toList();
  //     } else {
  //       throw Exception(
  //           'Failed to load programs. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching programs: $e');
  //   }
  // }
  // // get programs by Academiec

  // Future<List<EventData>> getProgramsByAcademiec(String academiecName) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/Api/programs_by_academies?program_category=$academiecName'),
  //       headers: {'Authorization': 'Basic $basicAuth'},
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body);
  //       return jsonData.map((json) => EventData.fromJson(json)).toList();
  //     } else {
  //       throw Exception(
  //           'Failed to load programs. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching programs: $e');
  //   }
  // }

  // user profile
  Future<UserModel> getUserProfile(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/get_profile?id=$id'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }
}
