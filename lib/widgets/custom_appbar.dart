import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/main.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.getTheme(); // Get the current theme

    return Stack(
      children: [
        // Background image with opacity
        Opacity(
          opacity: 0.05, // Set the opacity level as needed
          child: Image.asset(
            'assets/scaffold.jpg',
            fit: BoxFit.fitWidth, // Adjust the fit as needed
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // AppBar with a transparent background
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    Colors.black.withOpacity(0.4), // Color of the bottom border
                width: 0.7, // Adjust the width as needed
              ),
            ),
          ),
          child: AppBar(
            elevation: 0.1,
            toolbarHeight: 110,
            forceMaterialTransparency: true,
            toolbarOpacity: 0.9,
            centerTitle: true,
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Image.asset(
                    'assets/logo/cm.png',
                    width: 86.0,
                    height: 46.0,
                  ),
                ),
              ),
            ],
            leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: themeProvider.isDarkMode
                        ? theme.secondaryHeaderColor
                        : Colors.grey[800],
                    size: 30,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            backgroundColor: themeProvider.isDarkMode
                ? theme.primaryColor.withOpacity(0.5)
                : theme.primaryColor.withOpacity(0.5),
            // Set the AppBar background to transparent
            title: Center(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logo/appbar.png',
                  height: 46,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//

class CustomAppBarSecondary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.getTheme(); // Get the current theme

    return Stack(
      children: [
        // Background image with opacity
        Opacity(
          opacity: 0.05, // Set the opacity level as needed
          child: Image.asset(
            'assets/scaffold.jpg',
            fit: BoxFit.fitWidth, // Adjust the fit as needed
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // AppBar with a transparent background
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    Colors.black.withOpacity(0.4), // Color of the bottom border
                width: 0.7, // Adjust the width as needed
              ),
            ),
          ),
          child: AppBar(
            elevation: 0.1,
            toolbarHeight: 110,
            forceMaterialTransparency: true,
            toolbarOpacity: 0.9,
            centerTitle: true,
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Image.asset(
                    'assets/logo/cm.png',
                    width: 86.0,
                    height: 46.0,
                  ),
                ),
              ),
            ],
            leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: themeProvider.isDarkMode
                        ? theme.secondaryHeaderColor
                        : Colors.grey[800],
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            backgroundColor: themeProvider.isDarkMode
                ? theme.primaryColor.withOpacity(0.5)
                : theme.primaryColor.withOpacity(0.5),
            // Set the AppBar background to transparent
            title: Center(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logo/appbar.png',
                  height: 46,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
