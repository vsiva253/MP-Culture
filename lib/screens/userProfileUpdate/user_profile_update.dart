import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:mpc/screens/user/user_preferences_notifier.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfilUpdateView extends StatefulWidget {
  final UserModel user;
  const ProfilUpdateView({super.key, required this.user});

  @override
  State<ProfilUpdateView> createState() => _ProfilUpdateViewState();
}

void mySnackBarShow(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class _ProfilUpdateViewState extends State<ProfilUpdateView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void setUserData(UserModel user) {
    nameController.text = user.name ?? "NA";
    emailController.text = user.email ?? "NA";
    addressController.text = user.address ?? "NA";
    statusController.text = user.state ?? "NA";
    genderController.text = user.sex ?? "NA";
    dobController.text = user.dob ?? "NA";
    phoneNumberController.text = user.mobile ?? "NA";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late File _avatarImage; // Declare it as late

  @override
  void initState() {
    super.initState();
    setUserData(widget.user);
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
    final userViewModel = context.watch<UserViewModel>();
    var userData = userViewModel.userModel;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBarSecondary(),
      ),
      drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: CustomDrawer()),
      body: userViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
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
                              'Update Account',
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
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[400],
                                backgroundImage: (userData.profileimage != null)
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
                                          icon: const Icon(Icons.camera_alt),
                                          onPressed: _getImage,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    fillColor: Colors.grey[400],
                                    hintText: 'Enter your full name here',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: phoneNumberController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'Mobile Number',
                                    hintText: 'Enter your mobile number',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: addressController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    hintText: 'Enter your address',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: statusController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'State',
                                    hintText: 'Enter your State',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: genderController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    hintText: 'Enter your gender',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: dobController,
                                  style: const TextStyle(fontSize: 18),
                                  onTap: () {
                                    _selectDate();
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_month),
                                      onPressed: () async {
                                        _selectDate();
                                      },
                                    ),
                                    labelText: 'DOB',
                                    hintText: '12/05/1990',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(17, 8, 5, 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: const BorderSide(
                                        color: Colors.black, // Border color
                                        width: 0.3, // Border width
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 0.0, top: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child:
                                                      Consumer<UserPreferences>(
                                                    builder: (context,
                                                        userPreferences, _) {
                                                      return Transform.scale(
                                                        scale: 1.4,
                                                        child: Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                          side:
                                                              MaterialStateBorderSide
                                                                  .resolveWith(
                                                            (states) =>
                                                                const BorderSide(
                                                                    width: 1.5,
                                                                    color: Color(
                                                                        0xFF6815eb)),
                                                          ),
                                                          activeColor:
                                                              Colors.white,
                                                          checkColor:
                                                              const Color(
                                                                  0xFF6815eb),
                                                          value: userPreferences
                                                              .smsSelected,
                                                          onChanged: (value) {
                                                            Provider.of<UserPreferences>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateSMS(
                                                                    value ??
                                                                        false);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'एसएमएस',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text('SMS',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
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
                                                  child:
                                                      Consumer<UserPreferences>(
                                                    builder: (context,
                                                        userPreferences, _) {
                                                      return Transform.scale(
                                                        scale: 1.4,
                                                        child: Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                          side:
                                                              MaterialStateBorderSide
                                                                  .resolveWith(
                                                            (states) =>
                                                                const BorderSide(
                                                                    width: 1.5,
                                                                    color: Color(
                                                                        0xFF6815eb)),
                                                          ),
                                                          activeColor:
                                                              Colors.white,
                                                          checkColor:
                                                              const Color(
                                                                  0xFF6815eb),
                                                          value: userPreferences
                                                              .emailSelected,
                                                          onChanged: (value) {
                                                            Provider.of<UserPreferences>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateEmail(
                                                                    value ??
                                                                        false);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('ईमेल',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Text('Email',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
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
                                                  child:
                                                      Consumer<UserPreferences>(
                                                    builder: (context,
                                                        userPreferences, _) {
                                                      return Transform.scale(
                                                        scale: 1.4,
                                                        child: Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                          side:
                                                              MaterialStateBorderSide
                                                                  .resolveWith(
                                                            (states) =>
                                                                const BorderSide(
                                                                    width: 1.5,
                                                                    color: Color(
                                                                        0xFF6815eb)),
                                                          ),
                                                          activeColor:
                                                              Colors.white,
                                                          checkColor:
                                                              const Color(
                                                                  0xFF6815eb),
                                                          value: userPreferences
                                                              .bothSelected,
                                                          onChanged: (value) {
                                                            Provider.of<UserPreferences>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .updateBoth(
                                                                    value ??
                                                                        false);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('दोनों',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Text('Both',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
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
                                const SizedBox(height: 23),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Save Update")),
                                const SizedBox(height: 23),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
    );

    if (pickedDate != null) {
      String formattedDate =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      setState(() {
        dobController.text = formattedDate;
      });
    } else {
      mySnackBarShow(context, 'Please select a date');
    }
  }
}
