import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/screens/user/register_screen.dart';
import 'package:mpc/services/auth_login.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  bool showOtpField = false;
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
  //   checkLoggedInUser();
  // }

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

  @override
  Widget build(BuildContext context) {
    final loginModel = context.watch<LoginSignupViewModel>();
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
                    const Center(
                      child: Text(
                        'आपका स्वागत है',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.6),
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
                                    color:
                                        const Color(0xFFDcebfe).withOpacity(1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.4),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextField(
                                          controller:
                                              loginModel.mobileController,
                                          decoration: InputDecoration(
                                            hintText: 'Mobile No.',
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
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
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              showOtpField = true;
                                            });
                                            try {
                                              String response =
                                                  await AuthService.sendOTP(
                                                      loginModel
                                                          .mobileController
                                                          .text);
                                              CustomSnackbar.show(context,
                                                  "OTP Sent Successfully");
                                              print(
                                                  'OTP Sent Response: $response');

                                              // Show the OTP field after successfully sending OTP
                                            } catch (e) {
                                              // ignore: use_build_context_synchronously
                                              CustomSnackbar.show(context,
                                                  "Error sending OTP: $e");
                                              print('Error sending OTP: $e');
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFDcebfe)
                                                    .withOpacity(1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      // try {
                                                      //   // Replace 'cookieForSendingOTP' with the actual cookie value
                                                      //   String response =
                                                      //       await AuthService
                                                      //           .sendOTP(
                                                      //    loginModel. mobileController.text,
                                                      //   );
                                                      //   ScaffoldMessenger.of(
                                                      //           context)
                                                      //       .showSnackBar(
                                                      //     const SnackBar(
                                                      //       elevation: 10,
                                                      //       behavior:
                                                      //           SnackBarBehavior
                                                      //               .floating,
                                                      //       content: Text(
                                                      //           'OTP Sent Successfully'),
                                                      //     ),
                                                      //   );
                                                      //   print(
                                                      //       'OTP Sent Response: $response');
                                                      // } catch (e) {
                                                      //   CustomSnackbar.show(
                                                      //       context,
                                                      //       "Error sending OTP: $e");
                                                      //   print(
                                                      //       'Error sending OTP: $e');
                                                      // }

                                                      context
                                                          .read<
                                                              LoginSignupViewModel>()
                                                          .loginClick(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.call_outlined,
                                                      color: Colors.red
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                    flex: 3,
                                                    child: Text("Get OTP"))
                                              ],
                                            ),
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
                                      color: const Color(0xFFDcebfe)
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
                                            decoration: InputDecoration(
                                              hintText: 'Enter Your OTP',
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
                                    // if (loginModel
                                    //     .mobileController.text.isEmpty) {
                                    //   CustomSnackbar.show(
                                    //       context, "Please enter mobile no.");
                                    //   FocusScope.of(context).requestFocus(
                                    //       mobileFocusNode); // Set focus to mobile field
                                    //   return;
                                    // }

                                    // if (showOtpField &&
                                    //     loginModel.otpController.text.isEmpty) {
                                    //   CustomSnackbar.show(
                                    //       context, "Please enter OTP");
                                    //   FocusScope.of(context).requestFocus(
                                    //       otpFocusNode); // Set focus to OTP field
                                    //   return;
                                    // }

                                    // try {
                                    //   // Use the AuthProvider to verify OTP
                                    //   String response =
                                    //       await Provider.of<AuthProvider>(
                                    //     context,
                                    //     listen: false,
                                    //   ).verifyOTP(
                                    //     loginModel.mobileController.text,
                                    //     loginModel.otpController.text,
                                    //   );

                                    //   CustomSnackbar.show(context, response);

                                    //   // Set the login status
                                    //   Provider.of<AuthProvider>(context,
                                    //           listen: false)
                                    //       .setLoggedInStatus(true);

                                    //   Navigator.pushReplacement(
                                    //     context,
                                    //     FadePageRoute(
                                    //       builder: (BuildContext context) =>
                                    //           CustomBottomBar(
                                    //         selectedIndex: 0,
                                    //       ),
                                    //     ),
                                    //   );
                                    // } catch (e) {
                                    //   print('Error verifying OTP: $e');
                                    //   CustomSnackbar.show(context,
                                    //       "An error occurred. Please try again.");
                                    // }
                                    context
                                        .read<LoginSignupViewModel>()
                                        .otpCheck(context);
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
                                    child: const Center(
                                      child: Text(
                                        'लॉग इन करें',
                                        style: TextStyle(
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
                                    Navigator.pushReplacement(
                                        context,
                                        FadePageRoute(
                                            builder: (BuildContext context) =>
                                                const RegisterScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'अगर आपके पास खाता नहीं है?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'साइन अप करें',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
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
