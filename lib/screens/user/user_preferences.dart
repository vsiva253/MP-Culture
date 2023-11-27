import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/data/models/user_login_model.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesScreen extends StatelessWidget {
  void _saveLoginResponse(LoginResponse loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginResponse', json.encode(loginResponse.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
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
                                              value:
                                                  userPreferences.smsSelected,
                                              onChanged: (value) {
                                                Provider.of<UserPreferences>(
                                                        context,
                                                        listen: false)
                                                    .updateSMS(value ?? false);
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
                                                  userPreferences.emailSelected,
                                              onChanged: (value) {
                                                Provider.of<UserPreferences>(
                                                        context,
                                                        listen: false)
                                                    .updateEmail(
                                                        value ?? false);
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
                                              value:
                                                  userPreferences.bothSelected,
                                              onChanged: (value) {
                                                Provider.of<UserPreferences>(
                                                        context,
                                                        listen: false)
                                                    .updateBoth(value ?? false);
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
                                  onPressed: (userPreferences.smsSelected ||
                                          userPreferences.emailSelected ||
                                          userPreferences.bothSelected)
                                      ? () {
                                          Navigator.push(
                                              context,
                                              FadePageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                          // Register logic here585858
                                          print(
                                              'Registered: SMS - ${userPreferences.smsSelected}, Email - ${userPreferences.emailSelected}, Both - ${userPreferences.bothSelected}');
                                        }
                                      : null,
                                  child: const Text(
                                    'Register',
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
                                    _saveLoginResponse(
                                        LoginResponse(false, null));
                                    Navigator.push(
                                        context,
                                        FadePageRoute(
                                            builder: (context) =>
                                                CustomBottomBar(
                                                  selectedIndex: 0,
                                                ))); // Close the screen
                                  },
                                  child: const Text('Cancel',
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
