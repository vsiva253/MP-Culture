import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/option_screen.dart';
import 'package:mpc/services/auth_login.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  bool showOtpField = false;
  bool isOtpSent = false;

  Map<String, bool> toggledStates = {};
  // ValueNotifier to track login status
  ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(false);
  FocusNode mobileFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  // void setLoggedInFlag() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isLoggedIn', true);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // Check if the user is already logged in
  //   _listenForCode();
  // }

  Future<void> _listenForCode() async {
    if (isOtpSent) {
      SmsAutoFill().code.listen((String code) {
        final loginModel = context.read<LoginSignupViewModel>();
        loginModel.otpController.text = code;
        print(loginModel.nameController.text);
      });
    }
  }

  // void checkLoggedInUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  //   if (isLoggedIn) {
  //     // User is already logged in, set the notifier value to true
  //     isLoggedInNotifier.value = true;
  //   }
  // }
  @override
  void dispose() {
    mobileFocusNode.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendAutomaticOTP(
      String mobileNumber, BuildContext context) async {
    setState(() {
      showOtpField = true;
      isOtpSent = true;
    });

    context.read<LoginSignupViewModel>().loginClick(context);
  }

  // ... (other functions)

  // Future<void> _verifyOTP(String mobileNumber, String otp) async {
  //   try {
  //     await AuthService.verifyOTP(mobileNumber, otp);
  //     CustomSnackbar.show(context, "OTP Verified Successfully");

  //     // Set the login status
  //     Provider.of<AuthProvider>(context, listen: false).setLoggedInStatus(true);

  //     Navigator.pushReplacement(
  //       context,
  //       FadePageRoute(
  //         builder: (BuildContext context) => CustomBottomBar(
  //           selectedIndex: 0,
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     print('Error verifying OTP: $e');
  //     CustomSnackbar.show(context, "An error occurred. Please try again.");
  //   }
  // }
  void _changeLanguage(bool value) {
    if (value) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('hi', 'IN'));
    }
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final loginModel = context.watch<LoginSignupViewModel>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE52f08), // Set the color of the status bar
      // Set the color of the navigation bar (if present)
    ));
    StringValue.updateValues();
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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        StringValue.welcome,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
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
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(
                            color: themeProvider.isDarkMode
                                ? Colors.grey.withOpacity(0.4)
                                : Colors.grey.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode
                                        ? Colors.grey.withOpacity(0.4)
                                        : const Color(0xFFDcebfe)
                                            .withOpacity(1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.4),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: TextFormField(
                                          controller:
                                              loginModel.mobileController,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: StringValue.mobileNo,
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.0),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            // Check if the entered number is 10 digits, then automatically send OTP
                                            if (value.length == 10) {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              FocusScope.of(context)
                                                  .requestFocus(otpFocusNode);
                                              _sendAutomaticOTP(value, context);
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.call_outlined,
                                            color: Colors.red.withOpacity(0.6),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                // Password Field
                                if (showOtpField)
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode
                                          ? Colors.grey.withOpacity(0.4)
                                          : const Color(0xFFDcebfe)
                                              .withOpacity(1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.4),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: TextField(
                                            controller:
                                                loginModel.otpController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              hintText: StringValue.enterOtp,
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.0),
                                                  width: 0,
                                                ),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.lock_outlined,
                                              color:
                                                  Colors.red.withOpacity(0.6),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (loginModel
                                        .mobileController.text.isEmpty) {
                                      CustomSnackbar.show(
                                          context, StringValue.enterMobileNo);
                                      FocusScope.of(context).requestFocus(
                                          mobileFocusNode); // Set focus to mobile field
                                      return;
                                    }

                                    if (showOtpField &&
                                        loginModel.otpController.text.isEmpty) {
                                      CustomSnackbar.show(
                                          context, StringValue.enterOtp);
                                      FocusScope.of(context).requestFocus(
                                          otpFocusNode); // Set focus to OTP field
                                      return;
                                    }
                                    try {
                                      await AuthService.verifyOTP(
                                          loginModel.mobileController.text,
                                          loginModel.otpController.text);
                                    } catch (e) {
                                      print(e.toString());
                                    }

                                    bool isLogin = await context
                                        .read<LoginSignupViewModel>()
                                        .otpCheck(context);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoggedInStatus(isLogin);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFE52f08)
                                        // gradient: LinearGradient(
                                        //   colors: [
                                        //     Color(0xFF1D2671),
                                        //     Color(0xFFC33764)
                                        //   ],
                                        //   stops: [0.0, 1.0],
                                        //   transform: GradientRotation(
                                        //       122.32 * 3.1415927 / 180),
                                        // ),
                                        ),
                                    child: Center(
                                      child: Text(
                                        StringValue.logIn,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        FadePageRoute(
                                            builder: (BuildContext context) =>
                                                const OptionScreenView()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'register_please'.tr(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white.withOpacity(0.6)
                                              : Colors.grey.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        // StringValue.signUp,
                                        'register_please2'.tr(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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
