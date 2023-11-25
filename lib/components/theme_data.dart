import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color primaryColorl = Colors.white;
const Color primaryColor = Color(0xFF1E1E1E);
const Color secondaryColor = Color(0xFFC33764);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: primaryColorl,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColorl,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondaryColor,
    selectedItemColor: primaryColorl,
    unselectedItemColor: Colors.grey,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondaryColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
  ),
);

class ThemeProvider extends ChangeNotifier {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _isEnglishKey = 'isEnglish';

  bool _isDarkMode = false;
  bool _isEnglish = true;

  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;
    _isEnglish = prefs.getBool(_isEnglishKey) ?? true;
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, _isDarkMode);
    await prefs.setBool(_isEnglishKey, _isEnglish);
  }

  bool get isDarkMode => _isDarkMode;
  bool get isEnglish => _isEnglish;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _savePreferences();
    notifyListeners();
  }

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    _savePreferences();
    notifyListeners();
  }

  ThemeData getTheme() {
    if (_isDarkMode) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }
}
