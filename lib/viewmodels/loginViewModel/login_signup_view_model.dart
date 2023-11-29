// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:mpc/screens/user/register_screen.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupViewModel extends ChangeNotifier {
  final ApiService apiService;

  LoginSignupViewModel({required this.apiService});

  // Controller
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  // register page Controller

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;
  bool get isLoading => _isLoading;

  // User login click
  Future<void> loginClick(BuildContext context) async {
    CustomSnackbar.show(context, "Sending OTP...");
    print("call for otp");
    try {
      print(" try call for otp");
      _isLoading = true;
      await apiService.login(mobileController.text);
      CustomSnackbar.show(context, 'OTP Sent Successfully');
      _isLoading = false;
      print("done call for otp");
    } catch (e) {
      print("failed call for otp");
      _isLoading = false;
      CustomSnackbar.show(context, 'Error fetching User Profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // veryfied OTP
  Future<bool> otpCheck(BuildContext context) async {
    CustomSnackbar.show(context, "OTP Veryfing....");
    try {
      _isLoading = true;
      UserModel? user =
          await apiService.verifyOTP(mobileController.text, otpController.text);
      CustomSnackbar.show(context, "OTP verified successfully!");
      _isLoading = false;
      CustomSnackbar.show(context, 'Login Success');
      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          FadePageRoute(
              builder: (BuildContext context) =>
                  CustomBottomBar(selectedIndex: 0)),
          (Route<dynamic> route) => false,
        );
        return true;
      } else {
        Navigator.push(
          context,
          FadePageRoute(
              builder: (BuildContext context) => const RegisterScreen()),
        );
        return false;
      }
    } catch (e) {
      print("failed call for verfy otp $e");
      _isLoading = false;
      CustomSnackbar.show(context, 'Error: invalid otp $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // logout
  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginResponse');
    Navigator.pushAndRemoveUntil(
      context,
      FadePageRoute(builder: (BuildContext context) => UserPreferencesScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // check field is empity or not

  bool _validateFields(BuildContext context) {
    if (mobileController.text.isEmpty ||
        emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showCustomSnackbar(context, 'Please fill in all the required fields.');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showCustomSnackbar(context, 'Passwords do not match.');
      return false;
    }
    return true;
  }

  // user signup api
  Future<bool> userSignUp(BuildContext context) async {
    if (_validateFields(context)) {
      try {
        _isLoading = true;
        await apiService.signUp(
            nameController.text,
            emailController.text,
            mobileController.text,
            passwordController.text,
            confirmPasswordController.text);
        _isLoading = false;
        Navigator.pushAndRemoveUntil(
          context,
          FadePageRoute(
              builder: (BuildContext context) =>
                  CustomBottomBar(selectedIndex: 0)),
          (Route<dynamic> route) => false,
        );

        return true;
      } catch (e) {
        _isLoading = false;
        CustomSnackbar.show(context, 'Error: Failed to Register $e');
        return false;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      // Handle validation error here
      CustomSnackbar.show(context, 'Please fill in all the required fields.');
      return false;
    }
  }
}
