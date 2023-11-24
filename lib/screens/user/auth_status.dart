import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  // ValueNotifier to track login status
  ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(false);

  bool get isLoggedIn => isLoggedInNotifier.value;

  // Function to set the login status
  Future<void> setLoggedInStatus(bool value) async {
    isLoggedInNotifier.value = value;
    notifyListeners();

    // Save the login status in local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  // Function to send OTP
  // Future<String> sendOTP(String mobileNumber) async {
  //   // Add your implementation to send OTP
  //   // You can update the login status if sending OTP is successful
  //   await setLoggedInStatus(true);
  //   return 'OTP Sent Successfully';
  // }

  // Function to verify OTP
  Future<String> verifyOTP(String mobileNumber, String otp) async {
    // Add your implementation to verify OTP
    // You can update the login status if OTP verification is successful
    await setLoggedInStatus(true);
    return 'OTP Verified Successfully';
  }

  // Function to check the login status from local storage
  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedInNotifier.value = isLoggedIn;
    notifyListeners();
  }
}
