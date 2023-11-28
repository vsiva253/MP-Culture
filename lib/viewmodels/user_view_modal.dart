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
  bool _isBoothEnable = false;

  UserModel get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isLogin => _isLogin;
  bool get isSmsEnalbe => _isSmaEnable;
  bool get isEmailEnable => _isEmailEnable;
  bool get isBothEnable => _isBoothEnable;

  LoginResponse? get userLoginData => _savedLoginResponse;

  void bothEnable() {
    _isBoothEnable = !_isBoothEnable;
    notifyListeners();
    if (isBothEnable) {
      _isSmaEnable = true;
      _isEmailEnable = true;
      notifyListeners();
      saveBothNotification(true, true);
    } else {
      _isSmaEnable = false;
      _isEmailEnable = false;
      notifyListeners();
    }
  }

  void checkIsBothEnableOrNot() {
    if (_isSmaEnable && _isEmailEnable) {
      _isBoothEnable = true;
      notifyListeners();
    } else {
      _isBoothEnable = false;
      notifyListeners();
    }
  }

  void saveBothNotification(bool isSmsEnable, bool isEmailEnable) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save the boolean values to SharedPreferences
    prefs.setBool('isSmsEnable', isSmsEnable);
    prefs.setBool('isEmailEnable', isEmailEnable);
  }

  void toggleSms() async {
    print("print");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSmsEnable', !_isSmaEnable);
    getSmsEnable();
    Future.delayed(const Duration(microseconds: 1), () {
      checkIsBothEnableOrNot();
    });

    notifyListeners();
  }

  void toggleEmail() async {
    print("print");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEmailEnable', !_isEmailEnable);
    getEmailEnable();
    Future.delayed(const Duration(microseconds: 10), () {
      checkIsBothEnableOrNot();
    });
    notifyListeners();
  }

  Future<void> getSmsEnable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSmaEnable = prefs.getBool('isSmsEnable') ?? false;
    notifyListeners();
  }

  Future<void> getEmailEnable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEmailEnable = prefs.getBool('isEmailEnable') ?? false;
    notifyListeners();
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
      Future.delayed(const Duration(seconds: 1), () {
        fetchUserProfil(context);
      });
    } else {
      _isLoading = false;
      _savedLoginResponse = LoginResponse(false, null);
      notifyListeners();
    }
  }

  // User profile data
  Future<void> fetchUserProfil(BuildContext context) async {
    if (!(_userModel.id != null)) {
      try {
        _isLoading = true;
        final programs = await apiService
            .getUserProfile(_savedLoginResponse!.currentUser!.id!);
        _userModel = programs;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(
            'isSmsEnable', _userModel.smsEnable == '1' ? true : false);
        prefs.setBool(
            'isEmailEnable', _userModel.emailEnable == '1' ? true : false);
      } catch (e) {
        CustomSnackbar.show(context, 'Error fetching User Profile: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  int _smsEnable() {
    if (isSmsEnalbe) {
      return 1;
    } else {
      return 0;
    }
  }

  int _emailEnable() {
    if (isEmailEnable) {
      return 1;
    } else {
      return 0;
    }
  }

  // update profile

  Future<void> updateUserProfile(
    BuildContext context, {
    required String id,
    required String name,
    String email = 'NA',
    required String mobile,
    String sex = 'NA',
    String state = 'NA',
    String address = 'NA',
    String dob = 'NA',
  }) async {
    try {
      await apiService.updateProfile(
          id: id,
          name: name,
          mobile: mobile,
          email: email,
          sex: sex,
          address: address,
          state: state,
          dob: dob,
          smsEnable: _smsEnable(),
          emailEnable: _emailEnable());
      clearUser();
      fetchUserProfil(context);
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
    }
  }
}
