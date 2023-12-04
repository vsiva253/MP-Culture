import 'dart:js';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';

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
      return 'home'.tr();
    case 1:
      return 'academies'.tr();
    case 2:
      return 'live'.tr();
    case 3:
      return 'calendar'.tr();
    case 4:
      return 'profile'.tr();
    default:
      return 'add'.tr();
  }
}

Widget _buildFloatingActionButton(int selectedIndex) {
  return Stack(
    children: <Widget>[
      for (int i = 0; i < 5; i++)
        Positioned(
          bottom: 20.0,
          left: i * (MediaQuery.of(context as BuildContext).size.width / 5) +
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
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        transform: GradientRotation(122.32 * 3.1415927 / 180),
      ),
    ),
    child: Center(
      child: Image.asset(
        imagePath,
        color: Colors.white,
        height: 25,
        width: 25,
        fit: BoxFit.cover, // Use Image.asset instead of Icon
      ),
    ),
  );
}

Widget _getBottomBar(int selectedIndex) {
  final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
  final theme = themeProvider.getTheme(); // Get the current theme

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    elevation: 0.1,
    showSelectedLabels: false, // Show labels for selected items
    showUnselectedLabels: true, // Show labels for unselected items
    items: [
      for (int i = 0; i < 5; i++)
        BottomNavigationBarItem(
          icon: Visibility(
            visible: i != 0,
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
    currentIndex: 0,
    selectedItemColor: Colors.transparent,
    unselectedItemColor: themeProvider.isDarkMode
        ? Colors.grey.shade200.withOpacity(0.9)
        : Colors.black.withOpacity(0.9),
    backgroundColor: themeProvider.isDarkMode
        ? Colors.grey.shade800.withOpacity(0.4)
        : theme.primaryColor,
    onTap: (index) {
      Navigator.push(
          context as BuildContext,
          FadePageRoute(
              builder: (context) => CustomBottomBar(selectedIndex: index)));
      // setState(() {
      //   // widget.onTabTapped(index);
      // });
    },
  );
}
