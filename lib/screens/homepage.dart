import 'package:flutter/material.dart';
import 'package:mpc/components/event_card.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:mpc/widgets/homepage_widgets/categories.dart';
import 'package:mpc/widgets/homepage_widgets/peogram_list.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().fetchTodayPrograms(context);
    context.read<HomeViewModel>().fetchOnGoingPrograms(context);
    context.read<HomeViewModel>().fetchUpComingPrograms(context);
    context.read<HomeViewModel>().fetchArchivedPrograms(context);
    context.read<HomeViewModel>().fetchAboutUs(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: CustomDrawer()),
      body: homeViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const RowWithCards(),
                        const SizedBox(
                          height: 20,
                        ),
                        // const SkeletonList(itemCount: 3),
                        const SizedBox(
                          height: 226,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 19,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GradientText(
                                      'About Us',
                                      style: const TextStyle(
                                          fontFamily: 'Hind',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          height: 1),
                                      colors: const [
                                        Color(0xFFC33764),
                                        Color(0xFF1D2671),
                                      ],
                                      stops: const [0.0, 1],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                homeViewModel.about,
                                style: const TextStyle(
                                    fontSize: 16, // Set text size
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF797494) // Set font weight
                                    ),

                                maxLines: homeViewModel.isExpanded
                                    ? 1000
                                    : 3, // Show only three lines if not expanded
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      homeViewModel.isExpanded
                                          ? 'Read Less'
                                          : 'Read More',
                                      style: const TextStyle(
                                          color: Color(0xFF797494)),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  homeViewModel.isExpanded =
                                      !homeViewModel.isExpanded;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //       padding:
                        //           const EdgeInsets.only(left: 16, right: 16),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           GradientText(
                        //             "Today Program", //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                        //             style: const TextStyle(
                        //               fontFamily: 'Hind',
                        //               fontSize: 16.0,
                        //               fontWeight: FontWeight.w600,
                        //               height: 1,
                        //             ),
                        //             colors: const [
                        //               Color(0xFFC33764),
                        //               Color(0xFF1D2671)
                        //             ],
                        //           ),
                        //           GradientText(
                        //             "View all", //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                        //             style: const TextStyle(
                        //               fontFamily: 'Hind',
                        //               fontSize: 14.0,
                        //               fontWeight: FontWeight.w600,
                        //               height: 1,
                        //             ),
                        //             colors: const [
                        //               Color(0xFFC33764),
                        //               Color(0xFF1D2671)
                        //             ],
                        //           ),
                        //         ],
                        //       )),
                        // ),
                        // EventListCard(
                        //     eventList: homeViewModel.todayPrograms,
                        //     program: "Today Program"),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.only(left: 16),
                        //   height: 375, // Set the height according to your needs
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: homeViewModel.todayPrograms.length,
                        //     itemBuilder: (context, index) {
                        //       final event = homeViewModel.todayPrograms[index];
                        //       return EventCard(
                        //         event: event,
                        //       );
                        //     },
                        //   ),
                        // ),

                        // const SizedBox(
                        //   height: 40,
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 16),
                        //     child: GradientText(
                        //       "OnGoing Program", //वर्तमान मैं संचालित हो रहे कार्यक्रम
                        //       style: const TextStyle(
                        //         fontFamily: 'Hind',
                        //         fontSize: 16.0,
                        //         fontWeight: FontWeight.w600,
                        //         height: 1,
                        //       ),
                        //       colors: const [
                        //         Color(0xFFC33764),
                        //         Color(0xFF1D2671)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // homeViewModel.onGoingPrograms.isNotEmpty
                        //     ? Container(
                        //         padding: const EdgeInsets.only(left: 16),
                        //         height:
                        //             375, // Set the height according to your needs
                        //         child: ListView.builder(
                        //           scrollDirection: Axis.horizontal,
                        //           itemCount:
                        //               homeViewModel.onGoingPrograms.length,
                        //           itemBuilder: (context, index) {
                        //             final event =
                        //                 homeViewModel.onGoingPrograms[index];
                        //             return EventCard(
                        //               event: event,
                        //             );
                        //           },
                        //         ),
                        //       )
                        //     : const Center(
                        //         child: Text("Data is not available")),
                        // const SizedBox(height: 20),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 16),
                        //     child: GradientText(
                        //       "UpComing Program", //वर्तमान मैं संचालित हो रहे कार्यक्रम
                        //       style: const TextStyle(
                        //         fontFamily: 'Hind',
                        //         fontSize: 16.0,
                        //         fontWeight: FontWeight.w600,
                        //         height: 1,
                        //       ),
                        //       colors: const [
                        //         Color(0xFFC33764),
                        //         Color(0xFF1D2671)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.only(left: 16),
                        //   height: 375, // Set the height according to your needs
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: homeViewModel.upConingPrograms.length,
                        //     itemBuilder: (context, index) {
                        //       final event =
                        //           homeViewModel.upConingPrograms[index];
                        //       return EventCard(
                        //         event: event,
                        //       );
                        //     },
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 16),
                        //     child: GradientText(
                        //       "Archived Program", //वर्तमान मैं संचालित हो रहे कार्यक्रम
                        //       style: const TextStyle(
                        //         fontFamily: 'Hind',
                        //         fontSize: 16.0,
                        //         fontWeight: FontWeight.w600,
                        //         height: 1,
                        //       ),
                        //       colors: const [
                        //         Color(0xFFC33764),
                        //         Color(0xFF1D2671)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.only(left: 16),
                        //   height: 375, // Set the height according to your needs
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: homeViewModel.archivedPrograms.length,
                        //     itemBuilder: (context, index) {
                        //       final event =
                        //           homeViewModel.archivedPrograms[index];
                        //       return EventCard(
                        //         event: event,
                        //       );
                        //     },
                        //   ),
                        // ),
                        EventListCard(
                            eventList: homeViewModel.todayPrograms,
                            program: "Today Program"),
                        const SizedBox(
                          height: 20,
                        ),
                        EventListCard(
                            eventList: homeViewModel.onGoingPrograms,
                            program: "OnGoing Program"),
                        const SizedBox(
                          height: 20,
                        ),
                        EventListCard(
                            eventList: homeViewModel.upConingPrograms,
                            program: "UpComing Program"),
                        const SizedBox(
                          height: 20,
                        ),
                        EventListCard(
                            eventList: homeViewModel.archivedPrograms,
                            program: "Archived Program"),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
