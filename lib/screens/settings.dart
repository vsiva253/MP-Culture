import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpc/app_localixation.dart';
import 'package:mpc/components/theme_data.dart';
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
  Map<String, bool> toggledStates = {};
  // void _changeLanguage(bool isEnglish) {
  //   final locale = isEnglish ? Locale('en', 'US') : Locale('hi', 'IN');
  //   AppLocalizations.of(context)!.load(locale);
  // }
  late bool isEnglish;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set isEnglish based on the current language
    isEnglish = AppLocalizations.of(context)!.locale == Locale('en', 'US');
  }

  void _changeLanguage(bool isEnglish) {
    final locale = isEnglish ? Locale('en', 'US') : Locale('hi', 'IN');
    AppLocalizations.of(context)!.load(locale);
    setState(() {
      this.isEnglish = !isEnglish; // Corrected line
    });
  }

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
        child: CustomDrawer(),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/scaffold.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                  child: Container(
                    height: 74,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.7)),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ),
                                ),
                              );
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
                    icon: Icons.mark_email_unread_outlined,
                    onArrowPressed: () {
                      print('Arrow for Item 1 pressed');
                    },
                    initialValue: toggledStates['Email Notifications'] ?? false,
                    onToggleChanged: (value) {
                      setState(() {
                        toggledStates['Email Notifications'] = value;
                      });
                    },
                  ),
                ),
                CustomContainer(
                  text: 'SMS Notifications',
                  icon: Icons.notifications,
                  onArrowPressed: () {
                    print('Arrow for Item 1 pressed');
                  },
                  initialValue: toggledStates['SMS Notifications'] ?? false,
                  onToggleChanged: (value) {
                    setState(() {
                      toggledStates['SMS Notifications'] = value;
                    });
                  },
                ),
                CustomContainer(
                  text: 'Dark Mode',
                  icon: Icons.dark_mode_outlined,
                  onToggleChanged: (value) {
                    setState(() {
                      toggledStates['Dark Mode'] = value;
                    });
                    themeProvider.toggleTheme();
                    print('Toggle for Dark Mode changed to $value');
                  },
                  initialValue: toggledStates['Dark Mode'] ?? false,
                ),
                CustomLanguageContainer(
                  text: 'English',
                  icon: Icons.language_rounded,
                  onToggleChanged: (value) {
                    _changeLanguage(value);
                    setState(() {
                      toggledStates['English'] = value;
                    });
                  },
                  initialValue: false,
                ),
                CustomContainer(
                  text: 'Password',
                  icon: Icons.lock_outline,
                  showForwardArrow: true,
                  onArrowPressed: () {},
                  initialValue: toggledStates['Password'] ?? false,
                ),
                CustomContainer(
                  text: 'Privacy',
                  icon: Icons.privacy_tip_outlined,
                  showForwardArrow: true,
                  onArrowPressed: () {},
                  initialValue: toggledStates['Privacy'] ?? false,
                ),
                CustomContainer(
                  text: 'Support',
                  icon: Icons.contact_support_outlined,
                  showForwardArrow: true,
                  onArrowPressed: () {},
                  initialValue: toggledStates['Support'] ?? false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//ustomLanguageContainer

class CustomLanguageContainer extends StatefulWidget {
  final String text;
  final IconData icon;
  final ValueChanged<bool>? onToggleChanged;
  final bool initialValue;

  CustomLanguageContainer({
    required this.text,
    required this.icon,
    this.onToggleChanged,
    required this.initialValue,
  });

  @override
  _CustomLanguageContainerState createState() =>
      _CustomLanguageContainerState();
}

class _CustomLanguageContainerState extends State<CustomLanguageContainer> {
  late bool isToggled;
  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomLanguageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        isToggled = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 0),
      child: Container(
        height: 54,
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                gradient: LinearGradient(
                  colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                  stops: [0.0, 1.0],
                  transform: GradientRotation(122.32 * 3.1415927 / 180),
                ),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(widget.text, style: const TextStyle(fontSize: 16)),
            Expanded(child: SizedBox()),
            Transform.scale(
              scale: 0.6,
              child: CupertinoSwitch(
                trackColor: Colors.grey,
                thumbColor: Colors.white70,
                activeColor: Color(0xFFC33764),
                value: isToggled,
                onChanged: (value) {
                  if (widget.onToggleChanged != null) {
                    widget.onToggleChanged!(value);
                  }
                  setState(() {
                    isToggled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
