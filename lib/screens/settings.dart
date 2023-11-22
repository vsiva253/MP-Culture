import 'package:flutter/material.dart';
import 'package:mpc/main.dart';
import 'package:mpc/screens/profile.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/custom_container.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: CustomAppBar(),
        ),
        drawer: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            child: CustomDrawer()),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.05, // Set the opacity level
              child: Image.asset(
                'assets/scaffold.jpg', // Replace with your image path
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align children to the start (left)
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Center(
                      child: GradientText(
                        'Settings',
                        style: const TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                        colors: const [
                          Color(0xFFC33764),
                          Color(0xFF1D2671),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: Container(
                      height: 74,
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.7)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              width: 60,
                              child: const CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to the start (left)
                              children: [
                                Center(
                                  child: Text(
                                    "John Andrew",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Center(
                                  child: Text(
                                    "example@example.com",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    FadePageRoute(
                                        builder: (context) => CustomBottomBar(
                                              selectedIndex: 4,
                                            )));
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Center(
                    child: CustomContainer(
                      text: 'Email Notifications',
                      icon: Icons
                          .mark_email_unread_outlined, // Replace with the desired icon
                      onArrowPressed: () {
                        // Implement functionality for the arrow button of Item 1
                        print('Arrow for Item 1 pressed');
                      },
                      isDarkMode: themeProvider.isDarkMode,
                    ),
                  ),
                  // Inside your _SettingsState class
                  CustomContainer(
                    text: 'SMS Notifications',
                    icon: Icons.notifications, // Replace with the desired icon
                    onArrowPressed: () {
                      // Implement functionality for the arrow button of Item 1
                      print('Arrow for Item 1 pressed');
                    },
                    isDarkMode: themeProvider.isDarkMode,
                  ),

                  CustomContainer(
                    text: 'Dark Mode',
                    icon: Icons.dark_mode_outlined,
                    onToggleChanged: (value) {
                      themeProvider.toggleTheme();
                      print('Toggle for Dark Mode changed to $value');
                    },
                    isDarkMode: false, // Pass the isDarkMode value
                  ),

                  CustomContainer(
                    text: 'English',
                    icon:
                        Icons.language_rounded, // Replace with the desired icon
                    onToggleChanged: (value) {
                      // Implement functionality for the toggle button of Item 1
                      print('Toggle for Item 1 changed to $value');
                    },
                    isDarkMode: themeProvider.isDarkMode,
                  ),
                  CustomContainer(
                    text: 'Password',
                    icon: Icons.lock_outline, // Replace with the desired icon
                    showForwardArrow: true,
                    onArrowPressed: () {}, isDarkMode: themeProvider.isDarkMode,
                  ),
                  CustomContainer(
                    text: 'Privacy',
                    icon: Icons
                        .privacy_tip_outlined, // Replace with the desired icon
                    showForwardArrow: true,
                    onArrowPressed: () {}, isDarkMode: themeProvider.isDarkMode,
                  ),
                  CustomContainer(
                    text: 'Support',
                    icon: Icons
                        .contact_support_outlined, // Replace with the desired icon
                    showForwardArrow: true,
                    onArrowPressed: () {}, isDarkMode: themeProvider.isDarkMode,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
