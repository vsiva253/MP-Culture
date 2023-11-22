import 'package:flutter/material.dart';
import 'package:mpc/components/event_card.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:mpc/widgets/homepage_widgets/categories.dart';
import 'package:mpc/widgets/homepage_widgets/images_horizontal.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: ClipRRect(
          borderRadius: BorderRadius.only(
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
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const RowWithCards(),
                const SizedBox(
                  height: 20,
                ),
                // const SkeletonList(itemCount: 3),
                SizedBox(
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
                              colors: [
                                const Color(0xFFC33764),
                                const Color(0xFF1D2671),
                              ],
                              stops: [
                                0.0,
                                1,
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'मध्यप्रदेश की कला, साहित्य और संस्कृति को हर सम्भव उपायों द्वारा प्रोन्नत करना, सांस्कृतिक धरोहर, पुरातात्विक सम्पदा एवं ऐतिहासिक महत्व का यथास्थिति',
                        style: TextStyle(
                            fontSize: 16, // Set text size
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF797494) // Set font weight
                            ),
                        maxLines: 3, // Show only three lines if not expanded
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              isExpanded ? 'Read Less' : 'Read More',
                              style: const TextStyle(color: Color(0xFF797494)),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: GradientText("वर्तमान मैं संचालित हो रहे कार्यक्रम",
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                        colors: [
                          const Color(0xFFC33764),
                          const Color(0xFF1D2671),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        EventCard(),
                        SizedBox(
                          width: 20,
                        ),
                        EventCard(),
                        SizedBox(
                          width: 20,
                        ),
                        EventCard(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
