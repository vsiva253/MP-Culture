import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/screens/userProfileUpdate/user_profile_update.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/animation_page_route.dart';

import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:mpc/widgets/profile_text.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

void mySnackBarShow(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  late File _avatarImage; // Declare it as late

  @override
  void initState() {
    super.initState();
    // context.read<UserViewModel>().fetchUserProfile(context, 3);

    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.userLogin(context);
    _avatarImage = File(
        'assets/homepage/4.png'); // Initialize it with a default image path or any other valid initialization.
  }

  bool _showCameraIcon = true;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
        _showCameraIcon = false; // Hide the camera icon
      });
    }
  }

  late int selectedTabIndex = 4;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    var userData = userViewModel.userModel;
    StringValue.updateValues();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: const ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: CustomDrawer()),
      body: userViewModel.userLoginData?.isSuccess == true
          ? userViewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : userData.id == null
                  ? const Center(
                      child: Text("User Data Loading..."),
                    )
                  : Stack(
                      children: [
                        Opacity(
                          opacity: 0.05,
                          child: Image.asset(
                            'assets/scaffold.jpg',
                            width: double.maxFinite,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: GradientText(
                                      'Account',
                                      style: const TextStyle(
                                          fontFamily: 'Hind',
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                          height: 1),
                                      colors: const [
                                        Color(0xFFC33764),
                                        Color(0xFF1D2671),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey[400],
                                      backgroundImage: (userData.profileimage !=
                                              null)
                                          ? NetworkImage(userData.profileimage!)
                                              as ImageProvider<Object>?
                                          : (_avatarImage != null)
                                              ? FileImage(_avatarImage)
                                                  as ImageProvider<Object>?
                                              : null,
                                      child: _showCameraIcon
                                          ? Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: IconButton(
                                                icon: const Icon(
                                                    Icons.camera_alt),
                                                onPressed: _getImage,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                FadePageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProfilUpdateView(
                                                          user: userData,
                                                          userViewModel:
                                                              userViewModel,
                                                        )),
                                              );
                                            },
                                            child: Text("edit_profile".tr()),
                                          )),
                                      const SizedBox(height: 10),
                                      WidgetsClass.TextW(StringValue.fullName,
                                          userData.name ?? "NA"),
                                      WidgetsClass.TextW(StringValue.mobileNo,
                                          userData.mobile ?? "NA"),
                                      WidgetsClass.TextW(StringValue.email,
                                          userData.email ?? "NA"),
                                      WidgetsClass.TextW(StringValue.address,
                                          userData.address ?? "NA"),
                                      WidgetsClass.TextW(StringValue.state,
                                          userData.state ?? "NA"),
                                      WidgetsClass.TextW(StringValue.dob,
                                          userData.sex ?? "NA"),
                                      WidgetsClass.TextW("date_of_birth".tr(),
                                          userData.dob ?? "NA"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringValue.loginForView),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserPreferencesScreen(),
                        ),
                      );
                    },
                    child: Text(StringValue.logIn),
                  ),
                ],
              ),
            ),
    );
  }
}
