import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/components/card.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  int selectedTabIndex = 2;

  void getData() {
    context.read<HomeViewModel>().fetchOnGoingPrograms(context);

    context.read<UserViewModel>().userLogin(context);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();
    final userViewModel = context.watch<UserViewModel>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: const ClipRRect(
          borderRadius: BorderRadius.zero, child: CustomDrawer()),
      body: homeViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userViewModel.userLoginData?.isSuccess == true
              ? Stack(
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
                        padding:
                            const EdgeInsets.only(left: 1, right: 1, top: 0),
                        child: Column(
                          children: [
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GradientText(
                                    "live_program".tr(),
                                    //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                                    style: const TextStyle(
                                      fontFamily: 'Hind',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                    ),
                                    colors: const [
                                      Color(0xFFC33764),
                                      Color(0xFF1D2671)
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                            homeViewModel.onGoingPrograms.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: (homeViewModel
                                                  .onGoingPrograms.length /
                                              2)
                                          .ceil(),
                                      itemBuilder: (context, index) {
                                        var firstEventIndex = index * 2;
                                        var secondEventIndex = index * 2 + 1;

                                        return SizedBox(
                                          height: 395,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: EventCard(
                                                  event: homeViewModel
                                                          .onGoingPrograms[
                                                      firstEventIndex],
                                                  isLive: true,
                                                ),
                                              ),
                                              // Adjust the spacing between cards
                                              Expanded(
                                                child: secondEventIndex <
                                                        homeViewModel
                                                            .onGoingPrograms
                                                            .length
                                                    ? EventCard(
                                                        event: homeViewModel
                                                                .onGoingPrograms[
                                                            secondEventIndex],
                                                        isLive: true,
                                                      )
                                                    : const SizedBox(), // Check if the second item exists
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const Text("Event data not available"),
                          ],
                        ))
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringValue.loginForView),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserPreferencesScreen()),
                          );
                        },
                        child: Text(StringValue.logIn),
                      ),
                    ],
                  ),
                ),
    );
  }
}
