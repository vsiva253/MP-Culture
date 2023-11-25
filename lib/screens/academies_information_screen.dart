import 'package:flutter/material.dart';
import 'package:mpc/widgets/academies_programs.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AcademiesInformationScreen extends StatefulWidget {
  const AcademiesInformationScreen({super.key});

  @override
  State<AcademiesInformationScreen> createState() =>
      _AcademiesInformationScreenState();
}

class _AcademiesInformationScreenState
    extends State<AcademiesInformationScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBarSecondary(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 228,
              child: Image.asset(
                'assets/EventHeader.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3, left: 2, right: 2),
              color: Color(0xFFE91E63),
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "MP Culture department presents an Audience Capturing Application",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Container(
                // height: MediaQuery.of(context).size.height / 8.14,
                child: Image.asset(
                  "assets/academies_header.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                    "Bal Gandharva Rang Mandir",
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 16),
              child: const Align(
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      "About",
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
                    height: 10,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                    'nisi ut aliquip ex ea commodo consequat.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF797494),
                    ),
                    maxLines: isExpanded ? 1000 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          isExpanded ? 'Read Less' : 'Read More',
                          style: const TextStyle(color: Color(0xFF952766)),
                        ),
                      ],
                    ),
                    onTap: () {
                      isExpanded = !isExpanded;
                      setState(() {
                        isExpanded = isExpanded;
                      });
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
                        "More Information",
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                        "789848655555",
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
                        "https://www.culturemp.in/",
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
                        "example@example.com",
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
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.6),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GradientText(
                    "अकादमी के कार्यक्रम",
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                    colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                  )),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AccademiesProgramsCards(),
                    AccademiesProgramsCards(),
                    AccademiesProgramsCards(),
                    // Add more AccademiesProgramsCards as needed
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, top: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AccademiesProgramsCards(),
                    AccademiesProgramsCards(),
                    AccademiesProgramsCards(),
                    // Add more AccademiesProgramsCards as needed
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
