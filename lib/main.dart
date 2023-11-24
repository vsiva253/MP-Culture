import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/components/theme_data.dart';

import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/user_preferences.dart';

import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/widgets/bottombar.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => UserPreferences()),
        ChangeNotifierProvider(
          create: (context) {
            AuthProvider authProvider = AuthProvider();
            authProvider
                .checkLoggedInStatus(); // Check the login status from local storage
            return authProvider;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds before hiding the splash screen
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLoggedInNotifier =
        Provider.of<AuthProvider>(context).isLoggedInNotifier;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the color of the status bar
      // Set the color of the navigation bar (if present)
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: themeProvider.getTheme(),
      home: _showSplash
          ? SplashScreen()
          : ValueListenableBuilder<bool>(
              valueListenable: isLoggedInNotifier,
              builder: (context, isLoggedIn, child) {
                if (isLoggedIn) {
                  // User is logged in, navigate to the home screen
                  return CustomBottomBar(selectedIndex: 0);
                } else {
                  // User is not logged in, show user preferences screen
                  return UserPreferencesScreen();
                }
              },
            ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo/mpc.png',
          height: 100,
        ), // Replace with your splash image
      ),
    );
  }
}
