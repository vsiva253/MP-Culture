import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/categoryList/category_list_view.dart';
import 'package:mpc/screens/eventlist/event_list.dart';

import 'package:mpc/screens/settings.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selectedItem = 'My Profile';

  void setSelectedItem(String item) {
    setState(() {
      selectedItem = item;
    });
  }

  void getData() {
    context.read<HomeViewModel>().fetchTodayPrograms(context);
    context.read<HomeViewModel>().fetchUpComingPrograms(context);
    context.read<HomeViewModel>().fetchArchivedPrograms(context);
    context.read<HomeViewModel>().fetchAllCategories(context);
  }

  @override
  void initState() {
    context.read<UserViewModel>().userLogin(context);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    final theme = themeProvider.getTheme(); // Get the current theme

    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        width: MediaQuery.of(context).size.width * 0.675,
        backgroundColor: theme.drawerTheme.backgroundColor,
        child: Stack(
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
              child: Container(
                margin: const EdgeInsets.only(top: 0),
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.zero),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 60, left: 82, right: 82),
                          child: Center(
                            child: Image.asset(
                              'assets/logo/mpc.png',
                              height: 100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/profile.png',
                          text: 'My Profile',
                          isSelected: selectedItem == 'My Profile',
                          onTap: () {
                            setSelectedItem('My Profile');
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (context) => CustomBottomBar(
                                          selectedIndex: 4,
                                        )));
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/play.png',
                          text: 'live_program'.tr(),
                          isSelected: selectedItem == 'सीधा प्रसारण',
                          onTap: () {
                            setState(() {
                              selectedItem = 'सीधा प्रसारण';
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                      builder: (context) => CustomBottomBar(
                                            selectedIndex: 2,
                                          )));
                            });
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/light.png',
                          text: 'today_program'.tr(),
                          isSelected: selectedItem == 'आज के कार्यक्र',
                          onTap: () {
                            setSelectedItem('आज के कार्यक्र');
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (BuildContext context) =>
                                        EventListView(
                                          eventList:
                                              homeViewModel.todayPrograms,
                                          program: StringValue.todayProgram,
                                          ShowProgram: true,
                                        )));
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/light.png',
                          text: 'upcoming_program'.tr(),
                          isSelected: selectedItem == 'आगामी के कार्यक्रम',
                          onTap: () {
                            setSelectedItem('आगामी के कार्यक्रम');
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (BuildContext context) =>
                                        EventListView(
                                          eventList:
                                              homeViewModel.upConingPrograms,
                                          program: StringValue.upcomingProgram,
                                          ShowProgram: true,
                                        )));
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/save.png',
                          text: 'archived_program'.tr(),
                          isSelected: selectedItem == 'विगत कार्यक्रम',
                          onTap: () {
                            setSelectedItem('विगत कार्यक्रम');
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (BuildContext context) =>
                                        EventListView(
                                          eventList:
                                              homeViewModel.archivedPrograms,
                                          program: StringValue.archivedProgram,
                                          ShowProgram: true,
                                        )));
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/bookmark.png',
                          text: 'arts_categories'.tr(),
                          isSelected: selectedItem == 'कला विधायें',
                          onTap: () {
                            setSelectedItem('कला विधायें');
                            Navigator.push(
                                context,
                                FadePageRoute(
                                  builder: (context) => CategorysListView(
                                      categoryList: homeViewModel.category),
                                ));
                          },
                        ),
                        CustomDrawerItem(
                          image: 'assets/logo/settings.png',
                          text: 'settings'.tr(),
                          isSelected: selectedItem == 'Setting',
                          onTap: () {
                            setState(() {
                              selectedItem = 'Setting';
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                      builder: (context) => const Settings()));
                            });
                          },
                        ),
                        userViewModel.userLoginData!.isSuccess
                            ? CustomDrawerItem(
                                image: 'assets/logo/logout.png',
                                text: 'log_out'.tr(),
                                isSelected: selectedItem == 'Log Out',
                                onTap: () {
                                  setSelectedItem('Log Out');
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      contentPadding: const EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      title: const Text('Want to Logout?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await AuthProvider()
                                                .logout(context);
                                            context
                                                .read<UserViewModel>()
                                                .clearUser();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final Function onTap;

  CustomDrawerItem({
    required this.image,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Get the current theme
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                  border: isSelected
                      ? null
                      : const BorderDirectional(
                          bottom: BorderSide(color: Colors.grey, width: 0.2))),
              child: Container(
                height: isSelected ? 50 : 54,
                margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                          stops: [0.0, 1.0],
                          transform: GradientRotation(122.32 * 3.1415927 / 180),
                        )
                      : null,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: const AssetImage("assets/scaffold.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        isSelected
                            ? Colors.black.withOpacity(0.05)
                            : Colors.black.withOpacity(0.0),
                        BlendMode.dstATop),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 14),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          width: 24,
                          height: 24,
                          color: isSelected
                              ? themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.white
                              : themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        color: isSelected
                            ? themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.white
                            : themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
