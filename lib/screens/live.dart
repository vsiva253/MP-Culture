import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/screens/user/auth_status.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:mpc/widgets/homepage_widgets/peogram_list.dart';
import 'package:provider/provider.dart';
import 'package:mpc/screens/user/user_preferences.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  int selectedTabIndex = 2;

  void getData() {
    context.read<HomeViewModel>().fetchUpComingPrograms(context);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final isLoggedInNotifier =
        Provider.of<AuthProvider>(context).isLoggedInNotifier;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: ClipRRect(borderRadius: BorderRadius.zero, child: CustomDrawer()),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoggedInNotifier,
        builder: (context, isLoggedIn, child) {
          if (isLoggedIn) {
            // User is logged in, display the main content
            return Stack(
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
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          EventListCard(
                            eventList: homeViewModel.onGoingPrograms,
                            program: "live_program".tr(),
                            ShowProgram: false,
                          ),
                        ]),
                  ),
                )
              ],
            );
          } else {
            // User is not logged in, display a message prompting to log in
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please login to view this screen'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPreferencesScreen()),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
