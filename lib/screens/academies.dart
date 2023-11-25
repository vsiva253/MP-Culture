import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mpc/screens/academies_information_screen.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AcademiesPage extends StatefulWidget {
  const AcademiesPage({super.key});

  @override
  State<AcademiesPage> createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  int selectedTabIndex = 1;
  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GradientText(
                    'अकादमी',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                    colors: const [
                      Color(0xFFC33764),
                      Color(0xFF1D2671),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: // Inside your ListView.builder
                          ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      // Dummy data for illustration
                      String eventName = 'संस्कृति संचालनालय';
                      String eventDescription =
                          'माननीय राष्ट्रपति श्रीमती द्रौपदी मुर्मू 3 अगस्त, 2023 को सुबह 11:30 बजे भोपाल स्थित........';

                      // Generate random color
                      List<Color> colorList = [
                        Color(0xFF9750DB),
                        Color(0xFFD94D33),
                        Color(0xFF029CE2),
                        Color(0xFFFFB425),
                        Color(0xFFD361BA),
                      ];

                      // Randomly choose a color from the list
                      Color repeatColor = colorList[index % colorList.length];

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                      builder: (context) =>
                                          AcademiesInformationScreen()));
                              print("tapped on container");
                            },
                            child: Container(
                              height: 134,
                              padding: const EdgeInsets.only(
                                  left: 10, top: 27, bottom: 20),
                              decoration: BoxDecoration(
                                color: repeatColor, // Use the random color
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          eventName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          eventDescription,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Image.asset(
                                      'assets/school.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
