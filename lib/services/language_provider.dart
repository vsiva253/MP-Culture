import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const _LOCALE_KEY = 'preferredLocale';


  Locale _currentLocale = Locale('en', 'US');

  Locale get currentLocale => _currentLocale;


  Future<void> updateLanguage(Locale newLocale) async {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;

      // Save the new locale to SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(_LOCALE_KEY, newLocale.toString());

      notifyListeners();
    }
  }

  Future<void> loadPreferredLocale() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final preferredLocaleString = sharedPreferences.getString(_LOCALE_KEY);

    if (preferredLocaleString != null) {
      final preferredLocale = Locale(
        preferredLocaleString.split('_')[0], // language code
        preferredLocaleString.split('_')[1], // country code
      );
      _currentLocale = preferredLocale;
    }
  }

}
