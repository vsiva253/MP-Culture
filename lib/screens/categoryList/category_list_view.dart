import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/profile_text.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CategorysListView extends StatefulWidget {
  final List<CatrgoryModel> categoryList;
  const CategorysListView({super.key, required this.categoryList});

  @override
  State<CategorysListView> createState() => _CategorysListViewState();
}

class _CategorysListViewState extends State<CategorysListView> {
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.getTheme(); // Get the current theme

    StringValue.updateValues();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBarSecondary(),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
                context,
                FadePageRoute(
                    builder: (context) =>
                        CustomBottomBar(selectedIndex: index)));
            // setState(() {
            //   // widget.onTabTapped(index);
            // });
          },
        ),
        floatingActionButton: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            if (isKeyboardVisible) {
              return SizedBox
                  .shrink(); // Hide the FAB when the keyboard is visible
            } else {
              return _buildFloatingActionButton(0);
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                    StringValue.allCategory,
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      height: 2,
                    ),
                    colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                  child: ListView.builder(
                    itemCount: (widget.categoryList.length / 4).ceil(),
                    itemBuilder: (context, index) {
                      var startIndex = index * 4;
                      var endIndex =
                          (startIndex + 4) <= widget.categoryList.length
                              ? (startIndex + 4)
                              : widget.categoryList.length;

                      var itemsToDisplay =
                          widget.categoryList.sublist(startIndex, endIndex);

                      return SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var item in itemsToDisplay)
                              WidgetsClass.buildItem(
                                themeProvider.isEnglish
                                    ? item.category ?? "NA"
                                    : item.categoryHindi ?? "NA",
                                item.categoryIcon,
                                context,
                                [],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ])
          ],
        ));
  }
}
