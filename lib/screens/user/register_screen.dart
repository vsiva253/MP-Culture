import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/screens/user/login_screen.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/loginViewModel/login_signup_view_model.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedLanguage = 'English';

  void _changeLanguage(bool value) {
    if (value) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('hi', 'IN'));
    }
  }

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
  void initState() {
    super.initState();
    context.read<UserViewModel>().getEmailEnable();
    context.read<UserViewModel>().getSmsEnable();
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final signupModel = context.watch<LoginSignupViewModel>();
    final userViewModel = Provider.of<UserViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                                'sign_up_here'.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              value:
                                  themeProvider.isEnglish ? "English" : "Hindi",
                              onChanged: (String? newValue) {
                                setState(() {
                                  themeProvider.selectedLanguage = newValue!;
                                  themeProvider.toggleLanguage();
                                  _changeLanguage(themeProvider.isEnglish);
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
                              'audience_registration'.tr(),
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
                                    child: Text("${'mobile_number'.tr()}*",
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
                                            keyboardType: TextInputType.phone,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              hintText: 'mobile_number'.tr(),
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
                                    child: Text("${'email'.tr()}*",
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
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              hintText: 'email'.tr(),
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
                                    child: Text("${'full_name'.tr()}*",
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
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              hintText: 'full_name'.tr(),
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
                                    child: Text("${'password'.tr()}*",
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
                                            textInputAction:
                                                TextInputAction.next,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: 'password'.tr(),
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
                                    child: Text("${'caonfirm_password'.tr()}*",
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
                                            textInputAction:
                                                TextInputAction.done,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'caonfirm_password'.tr(),
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
                                                .userSignUp(context,
                                                    isEmailEnable: userViewModel
                                                        .isEmailEnable,
                                                    isSmsEnable: userViewModel
                                                        .isSmsEnalbe);
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
                                                'sign_up'.tr(),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              FadePageRoute(
                                                builder: (context) =>
                                                    CustomBottomBar(
                                                  selectedIndex: 0,
                                                ),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
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
                                                'cancel'.tr(),
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
                                          'have_account'.tr(),
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
                                          'login'.tr(),
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
