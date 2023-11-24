import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = Locale('en', 'US');

  Locale get currentLocale => _currentLocale;

  void updateLanguage(Locale newLocale) {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      notifyListeners();
    }
  }
}
