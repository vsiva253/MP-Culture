import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedLanguage = 'English';
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  // final ApiService _apiService =
  //     ApiService(); // Create an instance of ApiService

  // Future<void> registerUser() async {
  //   try {
  //     await _apiService.registerUser(
  //       name: nameController.text,
  //       email: emailController.text,
  //       mobile: mobileController.text,
  //       password: passwordController.text,
  //       confirmPassword: confirmPasswordController.text,
  //     );

  //     // Navigate to login screen after successful registration
  //     Navigator.pushReplacement(
  //       context,
  //       FadePageRoute(builder: (context) => const LoginScreen()),
  //     );
  //   } catch (e) {
  //     // Handle errors
  //     print("Error: $e");
  //     showCustomSnackbar(context, 'Registration Failed! Try Again :)');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final signupModel = context.watch<LoginSignupViewModel>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE52f08),
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
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 82, right: 82),
                        child: Center(
                          child: Image.asset(
                            'assets/logo/mpc.png',
                            height: 90,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(
                                selectedLanguage == 'English'
                                    ? 'Sign Up Here !'
                                    : 'यहाँ साइन अप करें!',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              value: selectedLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLanguage = newValue!;
                                });
                              },
                              items: <String>[
                                'English',
                                'Hindi'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFE52f08),
                          ),
                          child: Center(
                            child: Text(
                              selectedLanguage == 'English'
                                  ? 'Audience Registration'
                                  : "दर्शक पंजीकरण",
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        selectedLanguage == 'English'
                                            ? "Mobile Number*"
                                            : "मोबाइल नंबर*",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
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
                                          flex: 6,
                                          child: TextField(
                                            controller:
                                                signupModel.mobileController,
                                            decoration: InputDecoration(
                                              hintText: 'Mobile No.',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
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
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(
                                        //       Icons.call_outlined,
                                        //       color:
                                        //           Colors.red.withOpacity(0.6),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        selectedLanguage == 'English'
                                            ? "Email*"
                                            : "ईमेल*",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
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
                                                signupModel.emailController,
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        selectedLanguage == 'English'
                                            ? "Full Name*"
                                            : "पूरा नाम*",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
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
                                                signupModel.nameController,
                                            decoration: InputDecoration(
                                              hintText: 'Full Name',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        selectedLanguage == 'English'
                                            ? "Password*"
                                            : "पासवर्ड*",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
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
                                                signupModel.passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: 'Password',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        selectedLanguage == 'English'
                                            ? "Confirm Password*"
                                            : "पासवर्ड की पुष्टि करें*",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
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
                                            controller: signupModel
                                                .confirmPasswordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: 'Confirm Password',
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                                    .withOpacity(0.6),
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
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 1,
                                  //       child: Text(
                                  //         'Choose Language:',
                                  //         style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: Colors.grey.withOpacity(0.6),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: DropdownButton<String>(
                                  //         value: selectedLanguage,
                                  //         onChanged: (String? newValue) {
                                  //           setState(() {
                                  //             selectedLanguage = newValue!;
                                  //           });
                                  //         },
                                  //         items: <String>['English', 'Hindi']
                                  //             .map<DropdownMenuItem<String>>(
                                  //                 (String value) {
                                  //           return DropdownMenuItem<String>(
                                  //             value: value,
                                  //             child: Text(value),
                                  //           );
                                  //         }).toList(),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () async {
                                            bool isSignUp = await signupModel
                                                .userSignUp(context);
                                            Provider.of<AuthProvider>(context,
                                                    listen: false)
                                                .setLoggedInStatus(isSignUp);
                                          },
                                          child: Container(
                                            width: double.maxFinite,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFFE52f08),
                                            ),
                                            child: Center(
                                              child: Text(
                                                selectedLanguage == 'English'
                                                    ? 'Register'
                                                    : "पंजीकरण करे",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.maxFinite,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xFFE52f08),
                                          ),
                                          child: Center(
                                            child: Text(
                                              selectedLanguage == 'English'
                                                  ? 'Cancel'
                                                  : "रद्द करें",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          FadePageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ));
                                      // Add your registration logic here
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          selectedLanguage == 'English'
                                              ? 'Already have an account?'
                                              : "पहले से ही खाता है?",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.withOpacity(01),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          selectedLanguage == 'English'
                                              ? 'Login'
                                              : "लॉग इन करें",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
