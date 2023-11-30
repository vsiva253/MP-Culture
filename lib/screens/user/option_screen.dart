import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/screens/webViewPage/web_view.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:provider/provider.dart';

class OptionScreenView extends StatefulWidget {
  const OptionScreenView({super.key});

  @override
  State<OptionScreenView> createState() => _OptionScreenViewState();
}

class _OptionScreenViewState extends State<OptionScreenView> {
  void _changeLanguage(bool value) {
    if (value) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('hi', 'IN'));
    }
  }

  Widget button(String btnName) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE52f08),
    ));
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 2 * 1.5,
      decoration: BoxDecoration(
        color: const Color(0xFFE52f08),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
          child: Text(
        btnName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    StringValue.updateValues();
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/scaffold.jpg',
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    Image.asset(
                      'assets/logo/mpc.png',
                      height: MediaQuery.of(context).size.height / 7.5,
                    ),
                    const SizedBox(height: 15),
                    DropdownButton<String>(
                      value: themeProvider.isEnglish ? "English" : "Hindi",
                      onChanged: (String? newValue) {
                        setState(() {
                          themeProvider.selectedLanguage = newValue!;
                          themeProvider.toggleLanguage();
                          _changeLanguage(themeProvider.isEnglish);
                        });
                      },
                      items: <String>['English', 'Hindi']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadePageRoute(
                                builder: (BuildContext context) =>
                                    UserPreferencesScreen()));
                      },
                      child: button(StringValue.registrationForProgram),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadePageRoute(
                                builder: (context) => const WebViewScreen(
                                      url: StringValue.artistRegisterUrl,
                                    )));
                      },
                      child: button(StringValue.registrationForArtist),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValue.haveAccount,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.withOpacity(01),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                FadePageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            StringValue.logIn,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          )
        ],
      )),
    );
  }
}
