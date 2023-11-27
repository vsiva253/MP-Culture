import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(false);

  bool get isLoggedIn => isLoggedInNotifier.value;

  Future<void> setLoggedInStatus(bool value) async {
    isLoggedInNotifier.value = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future<String> verifyOTP(String mobileNumber, String otp) async {
    await setLoggedInStatus(true);
    return 'OTP Verified Successfully';
  }

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedInNotifier.value = isLoggedIn;
    notifyListeners();
  }

  // New method for logout
// New method for logout
  Future<void> logout(BuildContext context) async {
    // Clear the login status
    await setLoggedInStatus(false);

    // Additional cleanup tasks (if needed)

    // Example: Navigate to the login screen
    Navigator.push(context, FadePageRoute(builder: (_) => LoginScreen()));
  }
}
