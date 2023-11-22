import 'package:flutter/material.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

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
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: themeProvider.getTheme(),
      home: CustomBottomBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
