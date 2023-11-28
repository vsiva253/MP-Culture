// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mpc/data/models/user_login_model.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService apiService;

  UserViewModel({required this.apiService});
  LoginResponse? _savedLoginResponse;
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isSmaEnable = false;
  bool _isEmailEnable = false;
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isLogin => _isLogin;
  bool get isSmsEnalbe => _isSmaEnable;
  bool get isEmailEnable => _isEmailEnable;
  LoginResponse? get userLoginData => _savedLoginResponse;

  void saveBothNotification(bool isSmsEnable, bool isEmailEnable) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save the boolean values to SharedPreferences
    prefs.setBool('isSmsEnable', isSmsEnable);
    prefs.setBool('isEmailEnable', isEmailEnable);
  }

  void toggleSms() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSmsEnable', !_isSmaEnable);
    getSmsEnable();
  }

  void toggleEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEmailEnable', !_isEmailEnable);
    getEmailEnable();
  }

  Future<void> getSmsEnable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSmaEnable = prefs.getBool('isSmsEnable') ?? false;
  }

  Future<void> getEmailEnable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEmailEnable = prefs.getBool('isEmailEnable') ?? false;
  }

  void clearUser() {
    _userModel = UserModel();
  }

  void userLogin(BuildContext context) async {
    _isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedLoginResponseString = prefs.getString('loginResponse');
    if (savedLoginResponseString != null) {
      final Map<String, dynamic> savedLoginResponseMap =
          json.decode(savedLoginResponseString);
      _savedLoginResponse = LoginResponse.fromJson(savedLoginResponseMap);
      notifyListeners();
      _isLogin = true;
      Future.delayed(const Duration(seconds: 3), () {
        _fetchUserProfil(context);
      });
    } else {
      _isLoading = false;
      _savedLoginResponse = LoginResponse(false, null);
      notifyListeners();
    }
  }

  // User profile data
  Future<void> _fetchUserProfil(BuildContext context) async {
    if (!(_userModel.id != null)) {
      try {
        _isLoading = true;
        final programs = await apiService
            .getUserProfile(_savedLoginResponse!.currentUser!.id!);
        _userModel = programs;
      } catch (e) {
        CustomSnackbar.show(context, 'Error fetching User Profile: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}
