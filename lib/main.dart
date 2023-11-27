import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/app_localixation.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/data/models/user_login_model.dart';

import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/user_preferences.dart';

import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/viewmodels/userviewmodel/user_view_model.dart';
import 'package:mpc/widgets/bottombar.dart';

import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mpc/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Retrieve the saved LoginResponse from SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? savedLoginResponseString = prefs.getString('loginResponse');
  final LoginResponse? savedLoginResponse;

  if (savedLoginResponseString != null) {
    final Map<String, dynamic> savedLoginResponseMap =
        json.decode(savedLoginResponseString);
    savedLoginResponse = LoginResponse.fromJson(savedLoginResponseMap);
    print(
        "if section print ${savedLoginResponse.isSuccess} user ${savedLoginResponse.currentUser!.id.toString()}");
  } else {
    savedLoginResponse = LoginResponse(false, null);
    print("else section print ${savedLoginResponse.isSuccess}");
  }

  var api = ApiService(
    baseUrl: 'https://service.codingbandar.com',
    basicAuth: 'YWRtaW46YWRtaW4=',
  );
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
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(apiService: api),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(apiService: api),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginSignupViewModel(apiService: api),
        ),
      ],
      child: MyApp(loginResponse: savedLoginResponse),
    ),
  );
}

class MyApp extends StatefulWidget {
  final LoginResponse? loginResponse;
  const MyApp({Key? key, required this.loginResponse});

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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      home: _showSplash
          ? SplashScreen()
          : ValueListenableBuilder<bool>(
              valueListenable: isLoggedInNotifier,
              builder: (context, isLoggedIn, child) {
                if (widget.loginResponse!.isSuccess) {
                  print(
                      "if of run section print ${(widget.loginResponse!.isSuccess)} user ${widget.loginResponse!.currentUser!.id.toString()}");
                  return CustomBottomBar(selectedIndex: 0);
                } else {
                  print(
                      "else of run section print ${(widget.loginResponse!.isSuccess)}");
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
