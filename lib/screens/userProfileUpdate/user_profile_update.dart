import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc/data/models/user_model.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfilUpdateView extends StatefulWidget {
  final UserModel user;
  final UserViewModel userViewModel;
  const ProfilUpdateView(
      {super.key, required this.user, required this.userViewModel});

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
    context.read<UserViewModel>().getEmailEnable();
    context.read<UserViewModel>().getSmsEnable();
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
    StringValue.updateValues();
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
      body: Stack(
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: GradientText(
                        StringValue.updateAccount,
                        style: const TextStyle(
                            fontFamily: 'Hind',
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
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
                          backgroundImage: (widget.user.profileimage != null)
                              ? NetworkImage(widget.user.profileimage!)
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
                              labelText: StringValue.fullName,
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
                              labelText: StringValue.mobileNo,
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
                              labelText: StringValue.email,
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
                              labelText: StringValue.address,
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
                              labelText: StringValue.state,
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
                              labelText: StringValue.gender,
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
                              labelText: StringValue.dob,
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: widget.userViewModel.isSmsEnalbe,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.userViewModel.toggleSms();
                                        });
                                      },
                                    ),
                                    Text(StringValue.smsEnable),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: widget.userViewModel.isEmailEnable,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.userViewModel.toggleEmail();
                                        });
                                      },
                                    ),
                                    Text(
                                      StringValue.emailEnable,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: widget.userViewModel.isBothEnable,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.userViewModel.bothEnable();
                                        });
                                      },
                                    ),
                                    const Text('both'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 23),
                          ElevatedButton(
                              onPressed: () {
                                context.read<UserViewModel>().updateUserProfile(
                                    context,
                                    id: widget.user.id!,
                                    name: nameController.text,
                                    mobile: phoneNumberController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    state: statusController.text,
                                    dob: dobController.text,
                                    sex: genderController.text);
                              },
                              child: Text(StringValue.updateSave)),
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

    String formattedDate =
        '${pickedDate?.day}-${pickedDate?.month}-${pickedDate?.year}';
    setState(() {
      dobController.text = formattedDate;
    });
  }
}
