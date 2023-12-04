import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mpc/components/theme_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/services/language_provider.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
//import flutter localization
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mpc/data/services/api_service.dart';

void main() async {
  // Create a GlobalKey<NavigatorState>
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
          create: (context) => LanguageProvider(),
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
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('hi', 'IN'),
        ],
        path: 'lib/lang',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
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
    Future.delayed(Duration(milliseconds: 6600), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appcastURL =
    //     'https://culture-mp-version-ccontrol.onrender.com/appcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
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
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
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
                if (isLoggedIn) {
                  // User is logged in, navigate to the home screen
                  return UpgradeAlert(
                      upgrader: Upgrader(
                        // appcastConfig: cfg,
                        canDismissDialog: false,
                        showIgnore: false,
                        showLater: false,
                        durationUntilAlertAgain: Duration(seconds: 1),
                      ),
                      child: CustomBottomBar(selectedIndex: 0));
                } else {
                  return UpgradeAlert(
                      upgrader: Upgrader(
                        // appcast: Appcast(),
                        // appcastConfig: cfg,
                        canDismissDialog: false,
                        showIgnore: false,
                        showLater: false,

                        // debugLogging: true

                        // debugDisplayOnce: true,
                        durationUntilAlertAgain: Duration(seconds: 1),
                        // dialogStyle: UpgradeDialogStyle.cupertino,
                        // onUpdate: () {
                        //   launchUrl(Uri.parse(
                        //       'https://play.google.com/store/apps/details?id=com.culture_mp.app&hl=en_US'));
                        //   return true;
                        // }
                      ),
                      child: UserPreferencesScreen());
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
          'assets/splash_screen.gif',
          height: 250,
          width: 250,
        ), // Replace with your splash image
      ),
    );
  }
}
