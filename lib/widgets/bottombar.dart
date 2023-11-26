import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';

import 'package:mpc/screens/academies.dart';
import 'package:mpc/screens/calendar.dart';
import 'package:mpc/screens/homepage.dart';
import 'package:mpc/screens/live.dart';
import 'package:mpc/screens/profile.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mpc/screens/settings.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  int selectedIndex;

  CustomBottomBar({
    required this.selectedIndex,
  });

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const AcademiesPage();
      case 2:
        return const LivePage();
      case 3:
        return const CalendarPage();
      case 4:
        return const ProfilePage();
      default:
        return Settings(); // Placeholder for the "Add" tab
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.getTheme(); // Get the current theme

    return Scaffold(
      body: _getPage(widget.selectedIndex),
      key: key,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.1,
        showSelectedLabels: false, // Show labels for selected items
        showUnselectedLabels: true, // Show labels for unselected items
        items: [
          for (int i = 0; i < 5; i++)
            BottomNavigationBarItem(
              icon: Visibility(
                visible: i != widget.selectedIndex,
                child: Image.asset(
                  _getTabIcon(i),
                  width: 24.0,
                  height: 24.0,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade100.withOpacity(0.9)
                      : Colors.black54.withOpacity(0.9),
                ),
              ),
              label: _getTabLabel(i),
              // Show labels for all items
            ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: themeProvider.isDarkMode
            ? Colors.grey.shade200.withOpacity(0.9)
            : Colors.black.withOpacity(0.9),
        backgroundColor: themeProvider.isDarkMode
            ? Colors.grey.shade800.withOpacity(0.4)
            : theme.primaryColor,
        onTap: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
        },
      ),
      floatingActionButton: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          if (isKeyboardVisible) {
            return SizedBox
                .shrink(); // Hide the FAB when the keyboard is visible
          } else {
            return _buildFloatingActionButton(widget.selectedIndex);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String _getTabIcon(int index) {
    switch (index) {
      case 0:
        return 'assets/bottombar/home.png'; // Return image path instead of icon code
      case 1:
        return 'assets/bottombar/aca.png'; // Return image path instead of icon code
      case 2:
        return 'assets/bottombar/live.png'; // Return image path instead of icon code
      case 3:
        return 'assets/bottombar/calendar.png'; // Return image path instead of icon code
      case 4:
        return 'assets/bottombar/user.png'; // Return image path instead of icon code
      default:
        return 'assets/bottombar/add.png'; // Return image path instead of icon code
    }
  }

  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Academies';
      case 2:
        return 'Live';
      case 3:
        return 'Calendar';
      case 4:
        return 'Profile';
      default:
        return 'Add';
    }
  }

  Widget _buildFloatingActionButton(int selectedIndex) {
    return Stack(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          Positioned(
            bottom: 20.0,
            left: i * (MediaQuery.of(context).size.width / 5) +
                (i == 0 ? 15.0 : 15),
            child: Visibility(
              visible: i == selectedIndex,
              child: _buildGradientFAB(_getTabIcon(i)),
            ),
          ),
      ],
    );
  }

  Widget _buildGradientFAB(String imagePath) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF1D2671), Color(0xFFC33764)],
          stops: [0.0, 1.0],
          transform: GradientRotation(122.32 * 3.1415927 / 180),
        ),
      ),
      child: Image.asset(
        imagePath,
        color: Colors.white, // Use Image.asset instead of Icon
      ),
    );
  }
}

UniqueKey key = UniqueKey();
