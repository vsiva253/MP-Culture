import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mpc/data/models/academies_model.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/homepage_widgets/peogram_list.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AcademiesInformationScreen extends StatefulWidget {
  final DepartmentModel acd;
  const AcademiesInformationScreen({super.key, required this.acd});

  @override
  State<AcademiesInformationScreen> createState() =>
      _AcademiesInformationScreenState();
}

class _AcademiesInformationScreenState
    extends State<AcademiesInformationScreen> {
  double hightOfSlider = 228;

  @override
  void initState() {
    super.initState();
    context
        .read<HomeViewModel>()
        .fetchAcademiecPrograms(context, widget.acd.id ?? "NA");
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();
    // var widget.acd = widget.acd;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBarSecondary(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: widget.acd.academyBanner != null ? hightOfSlider : 0,
                child: widget.acd.academyBanner != null
                    ? Image.network(
                        widget.acd.deptImage ?? "NA",
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // return Image.asset(
                          //   'assets/EventHeader.jpg',
                          //   fit: BoxFit.cover,
                          // );
                          setState(() {
                            hightOfSlider = 0;
                          });
                          return const SizedBox();
                        },
                      )
                    // : Image.asset(
                    //     'assets/EventHeader.jpg',
                    //     fit: BoxFit.cover,
                    //   ),
                    : const SizedBox()),
            Container(
              height: 25,
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 2, right: 2),
              color: Color(0xFFE91E63),
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: Marquee(
                  text: widget.acd.academyNotice == ''
                      ? 'MP Culture department presents an Audience Capturing Application'
                      : widget.acd.academyNotice ??
                          "MP Culture department presents an Audience Capturing Application",
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 60.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 20),
                    child: widget.acd.deptImage != null
                        ? SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              widget.acd.deptImage ?? "NA",
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // return Image.asset(
                                //   "assets/academies_header.jpg",
                                //   fit: BoxFit.cover,
                                // );
                                return const SizedBox();
                              },
                            ),
                          )
                        // : Container(
                        //     height: 80,
                        //     width: 80,
                        //     decoration: const BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         image: DecorationImage(
                        //             image: AssetImage(
                        //                 "assets/academies_header.jpg"))),

                        //     // child: Image.asset(
                        //     //   ,
                        //     //   fit: BoxFit.fitWidth,
                        //     // ),
                        //   ),
                        : const SizedBox()),
                Expanded(
                  child: GradientText(
                    widget.acd.deptName ?? "NA",
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                    colors: const [
                      Color(0xFFC33764),
                      Color(0xFF1D2671),
                    ],
                    stops: const [0.0, 1],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.acd.deptAddress ?? "NA",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 40, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("View on Maps",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFA01B8A))),
              ),
            ),
            // Add this line
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.6),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      StringValue.about,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      colors: const [
                        Color(0xFFC33764),
                        Color(0xFF1D2671),
                      ],
                      stops: const [0.0, 1],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.acd.deptAbout ?? "NA",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF797494),
                      ),
                      maxLines: homeViewModel.isExpanded ? 1000 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          homeViewModel.isExpanded
                              ? 'read_less'.tr()
                              : 'read_more'.tr(),
                          style: const TextStyle(color: Color(0xFF952766)),
                        ),
                      ],
                    ),
                    onTap: () {
                      homeViewModel.isExpanded = !homeViewModel.isExpanded;
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.6),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
              ),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientText(
                        "more_info".tr(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                        colors: const [
                          Color(0xFFC33764),
                          Color(0xFF1D2671),
                        ],
                        stops: const [0.0, 1],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: MediaQuery.of(context).size.height / 35.61,
                        width: 30,
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ]),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 21, right: 16, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.acd.deptMobile ?? "NA",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.language_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.acd.deptWebsite ?? "NA",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.acd.deptEmail ?? "NA",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.6),
            ),
            homeViewModel.isProgramoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : EventListCard(
                    eventList: homeViewModel.byAcaedmiecProgramList,
                    program: "अकादमी के कार्यक्रम",
                    showProgram: false,
                    isLive: false,
                  ),
            const SizedBox(height: 20),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //       padding: const EdgeInsets.only(left: 16, right: 16),
            //       child: GradientText(
            //         "अकादमी के कार्यक्रम",
            //         style: const TextStyle(
            //           fontFamily: 'Hind',
            //           fontSize: 24.0,
            //           fontWeight: FontWeight.w600,
            //           height: 1,
            //         ),
            //         colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
            //       )),
            // ),

            // Padding(
            //   padding: EdgeInsets.only(left: 16, top: 10),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         AccademiesProgramsCards(),
            //         AccademiesProgramsCards(),
            //         AccademiesProgramsCards(),
            //         // Add more AccademiesProgramsCards as needed
            //       ],
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: EdgeInsets.only(left: 16, top: 30),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         AccademiesProgramsCards(),
            //         AccademiesProgramsCards(),
            //         AccademiesProgramsCards(),
            //         // Add more AccademiesProgramsCards as needed
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
