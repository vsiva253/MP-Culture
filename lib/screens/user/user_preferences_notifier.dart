import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  bool a = false;
  bool b = false;
  bool smsSelected = false;
  bool emailSelected = false;
  bool bothSelected = false;
  Future<bool> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    smsSelected = prefs.getBool('smsSelected') ?? false;
    emailSelected = prefs.getBool('emailSelected') ?? false;
    bothSelected = prefs.getBool('bothSelected') ?? false;
    notifyListeners();

    return smsSelected || emailSelected || bothSelected;
  }

  Future<void> updateSMS(bool value) async {
    smsSelected = value;

    await _savePreferences();
    notifyListeners();
  }

  Future<void> updateEmail(bool value) async {
    emailSelected = value;

    await _savePreferences();
    notifyListeners();
  }

  Future<void> updateBoth(bool value) async {
    bothSelected = value;
    updateEmail(value);
    updateSMS(value);

    await _savePreferences();
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('smsSelected', smsSelected);
    prefs.setBool('emailSelected', emailSelected);
    prefs.setBool('bothSelected', bothSelected);
  }
}
