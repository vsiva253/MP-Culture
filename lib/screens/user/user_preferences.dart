import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  void _changeLanguage(bool value) {
    if (value) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('hi', 'IN'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    StringValue.updateValues();
    final userViewModel = Provider.of<UserViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE52f08), // Set the color of the status bar
      // Set the color of the navigation bar (if present)
    ));
    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 55, left: 82, right: 90),
                      child: Center(
                        child: Image.asset(
                          'assets/logo/mpc.png',
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          value: themeProvider.selectedLanguage,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.366,
                        decoration: BoxDecoration(
                            color: const Color(0xFFEb435a),
                            borderRadius: BorderRadius.circular(6)),
                        child: const Column(children: [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 30.0, right: 30.0, top: 16),
                                child: Text(
                                  "मध्यप्रदेश कल्चर एप में आपका स्वागत है",
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 16),
                              child: Text(
                                "यदि आप मध्यप्रदेश शासन संस्कृति विभाग द्वारा आयोजित होने वाले कार्यक्रमों की जानकारी SMS,Email अथवा दोनों विकल्पों के माध्यम से चाहते है तो नीचे दिए गए विकल्पों का चयन कर पंजीयन की कार्यवाही पूर्ण करें !",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 0.0, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Consumer<UserPreferences>(
                                        builder: (context, userPreferences, _) {
                                          return Transform.scale(
                                            scale: 1.4,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xFF6815eb)),
                                              ),
                                              activeColor: Colors.white,
                                              checkColor:
                                                  const Color(0xFF6815eb),
                                              value: userViewModel.isSmsEnalbe,
                                              onChanged: (value) {
                                                userViewModel.toggleSms();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'एसएमएस',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text('SMS',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Consumer<UserPreferences>(
                                        builder: (context, userPreferences, _) {
                                          return Transform.scale(
                                            scale: 1.4,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xFF6815eb)),
                                              ),
                                              activeColor: Colors.white,
                                              checkColor:
                                                  const Color(0xFF6815eb),
                                              value:
                                                  userViewModel.isEmailEnable,
                                              onChanged: (value) {
                                                userViewModel.toggleEmail();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ईमेल',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text('Email',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Consumer<UserPreferences>(
                                        builder: (context, userPreferences, _) {
                                          return Transform.scale(
                                            scale: 1.4,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xFF6815eb)),
                                              ),
                                              activeColor: Colors.white,
                                              checkColor:
                                                  const Color(0xFF6815eb),
                                              value: userViewModel.isBothEnable,
                                              onChanged: (value) {
                                                userViewModel.bothEnable();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('दोनों',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text('Both',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    Consumer<UserPreferences>(
                      builder: (context, userPreferences, _) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 42),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0.1),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                const Color(0xFFE52f08)),
                                  ),
                                  onPressed: (userViewModel.isSmsEnalbe ||
                                          userViewModel.isEmailEnable ||
                                          userViewModel.isBothEnable)
                                      ? () {
                                          Navigator.push(
                                              context,
                                              FadePageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                          // Register logic here585858
                                          print(
                                              'Registered: SMS - ${userPreferences.smsSelected}, Email - ${userPreferences.emailSelected}, Both - ${userPreferences.bothSelected}');
                                        }
                                      : null,
                                  child: Text(
                                    StringValue.register,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0.1),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                const Color(0xFF585858)),
                                  ),
                                  onPressed: () {
                                    // Cancel logic here
                                    Navigator.push(
                                        context,
                                        FadePageRoute(
                                            builder: (context) =>
                                                CustomBottomBar(
                                                  selectedIndex: 0,
                                                ))); // Close the screen
                                  },
                                  child: Text(StringValue.cancel,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
