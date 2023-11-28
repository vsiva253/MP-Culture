import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/screens/webViewPage/web_view.dart';
import 'package:mpc/widgets/animation_page_route.dart';

class OptionScreenView extends StatefulWidget {
  const OptionScreenView({super.key});

  @override
  State<OptionScreenView> createState() => _OptionScreenViewState();
}

class _OptionScreenViewState extends State<OptionScreenView> {
  String selectedLanguage = 'English';

  Widget button(String btnName) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE52f08),
    ));
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 2 * 1.5,
      decoration: BoxDecoration(
          color: const Color(0xFFE52f08),
          borderRadius: BorderRadius.circular(5)),
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
                      value: selectedLanguage,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLanguage = newValue!;
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
                      child: button(selectedLanguage == 'English'
                          ? "Registration for the programme"
                          : "कार्यक्रम हेतु पंजीयन"),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadePageRoute(
                                builder: (context) => const WebViewScreen()));
                      },
                      child: button(selectedLanguage == 'English'
                          ? "Registration of artist"
                          : "कलाकार का पंजीयन"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedLanguage == 'English'
                              ? 'Are you already registered?'
                              : "क्या आप पहले से पंजीकृत है?",
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
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            selectedLanguage == 'English'
                                ? 'Login'
                                : "लॉग इन करें",
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
