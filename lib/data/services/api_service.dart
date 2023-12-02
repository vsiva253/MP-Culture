import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mpc/data/models/academies_model.dart';
import 'package:mpc/data/models/appbar_model.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/data/models/single_academiec_model.dart';
import 'package:mpc/data/models/single_event_model.dart';
import 'package:mpc/data/models/user_login_model.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        return jsonData['about'];
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

  // user profile
  Future<UserModel> getUserProfile(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Api/get_profile?id=$id'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );
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

//save user login state
  void _saveLoginResponse(LoginResponse loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginResponse', json.encode(loginResponse.toJson()));
  }

  // user login api
  Future<Map<String, dynamic>> login(String mobile) async {
    try {
      final response = await http.post(
        Uri.parse('https://service.codingbandar.com/Api/login'),
        body: {'mobile': mobile},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw ('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error: $error');
    }
  }

// OTP verify api
  Future<UserModel?> verifyOTP(String mobile, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Api/verify_otp'),
      body: {
        'mobile': mobile,
        'otp': otp,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['user'] != null) {
        final Map<String, dynamic> userData = responseData['user'];

        if (responseData['register'] == 1) {
          UserModel user = UserModel.fromJson(userData);
          LoginResponse userResponse = LoginResponse(true, user);
          _saveLoginResponse(userResponse);
          return user;
        } else {
          return null;
        }
      } else {
        // Handle the case when 'user' is null
        return null;
      }
    } else {
      throw ('Request failed with status: ${response.statusCode}');
    }
  }

  // signup api
  Future<UserModel> signUp(String name, String email, String mobile,
      String password, String cpassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Api/signup'),
        body: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'password': password,
          'cpassword': cpassword,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> userData = responseData['user'];
        UserModel user = UserModel.fromJson(userData);
        LoginResponse userResponse = LoginResponse(true, user);
        _saveLoginResponse(userResponse);
        return user;
      } else {
        throw ('Registration failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error: $error');
    }
  }

  // update profile
  Future<bool> updateProfile({
    required String id,
    required String name,
    String email = 'NA',
    required String mobile,
    String sex = 'NA',
    String state = 'NA',
    String address = 'NA',
    String dob = 'NA',
    int smsEnable = 0,
    int emailEnable = 0,
  }) async {
    try {
      final Map<String, String> body = {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'sex': sex,
        'state': state,
        'address': address,
        'dob': dob,
        'sms_enable': smsEnable.toString(),
        'email_enable': emailEnable.toString(),
      };

      final response = await http.post(
        Uri.parse('$baseUrl/Api/profile_update'),
        headers: {'Authorization': 'Basic $basicAuth'},
        body: body,
      );

      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      throw ('Error updating profile: $e');
      // Handle error here
    }
  }

  Future<List<ToolbarImagesModel>> getToolbarImages() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Api/header_logo'),
          headers: {'Authorization': 'Basic $basicAuth'});

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);
        final List<ToolbarImagesModel> toolbarImagesList =
            dataList.map((json) => ToolbarImagesModel.fromJson(json)).toList();
        return toolbarImagesList;
      } else {
        throw ('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Failed to load data');
    }
  }
}
