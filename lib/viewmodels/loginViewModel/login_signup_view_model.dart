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
  // diloge loader
  Future<void> _showLoadingDialog(BuildContext context, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(title),
            ],
          ),
        );
      },
    );
  }

  // User login click
  Future<void> loginClick(BuildContext context) async {
    try {
      _showLoadingDialog(context, "OTP Sending...");
      await apiService.login(mobileController.text);
      CustomSnackbar.show(context, 'OTP Sent Successfully');
    } catch (e) {
      CustomSnackbar.show(context, 'Something Wrong');
    } finally {
      Navigator.of(context).pop();
      notifyListeners();
    }
  }

  // veryfied OTP
  Future<bool> otpCheck(BuildContext context) async {
    try {
      _showLoadingDialog(context, "OTP Veryfing....");
      UserModel? user =
          await apiService.verifyOTP(mobileController.text, otpController.text);
      Future.delayed(const Duration(seconds: 1));
      if (user != null) {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          FadePageRoute(
              builder: (BuildContext context) =>
                  CustomBottomBar(selectedIndex: 0)),
          (Route<dynamic> route) => false,
        );
        return true;
      } else {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          FadePageRoute(
              builder: (BuildContext context) => const RegisterScreen()),
        );
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(context, 'Error: invalid otp ');
      return false;
    } finally {
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
  Future<bool> userSignUp(
    BuildContext context, {
    required bool isSmsEnable,
    required bool isEmailEnable,
  }) async {
    if (_validateFields(context)) {
      _showLoadingDialog(context, "Registring....");
      try {
        _isLoading = true;
        UserModel user = await apiService.signUp(
          nameController.text,
          emailController.text,
          mobileController.text,
          passwordController.text,
          confirmPasswordController.text,
        );
        Future.delayed(const Duration(seconds: 1), () {
          if (user.id != null) {
            updateUserProfile(
              context,
              id: user.id!,
              name: user.name ?? "NA",
              email: user.email ?? "NA",
              mobile: user.mobile ?? "NA",
              isSmsEnalbe: isSmsEnable,
              isEmailEnalbe: isEmailEnable,
            );
          }
        });
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          FadePageRoute(
            builder: (BuildContext context) =>
                CustomBottomBar(selectedIndex: 0),
          ),
          (Route<dynamic> route) => false,
        );

        return true;
      } catch (error) {
        Navigator.of(context).pop();
        CustomSnackbar.show(context, 'Error: Failed to Register $error');
        return false;
      } finally {
        notifyListeners();
      }
    } else {
      // Handle validation error here
      CustomSnackbar.show(context, 'Please fill in all the required fields.');
      return false;
    }
  }

  // update notification
  Future<void> updateUserProfile(
    BuildContext context, {
    required String id,
    required String name,
    required String email,
    required String mobile,
    required bool isSmsEnalbe,
    required bool isEmailEnalbe,
  }) async {
    try {
      await apiService.updateProfile(
          id: id,
          name: name,
          mobile: mobile,
          email: email,
          sex: "NA",
          address: "NA",
          state: "NA",
          dob: "NA",
          smsEnable: isSmsEnalbe ? 1 : 0,
          emailEnable: isEmailEnalbe ? 1 : 0);
    } catch (e) {
      throw ('Error: $e');
    }
  }
}
