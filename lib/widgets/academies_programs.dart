import 'package:flutter/material.dart';

class AccademiesProgramsCards extends StatefulWidget {
  const AccademiesProgramsCards({super.key});

  @override
  State<AccademiesProgramsCards> createState() =>
      _AccademiesProgramsCardsState();
}

class _AccademiesProgramsCardsState extends State<AccademiesProgramsCards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 206,
      width: 174,
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/aca_galary.jpg',
                  height: 111,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  left: 106,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 1, top: 1),
                    height: 10,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC33764),
                          Color(0xFF1D2671),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        'Event Date',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'HIND',
                          fontWeight: FontWeight.w500,
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 9,
                  left: 106,
                  right: 0,
                  child: Container(
                    height: 9,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC33764),
                          Color(0xFF714ACF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, top: 1),
                      child: Text(
                        'start time - end time',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'HIND',
                          fontWeight: FontWeight.w500,
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFC33764),
                      Color(0xFF1D2671),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Transform.scale(
                        scale: 0.9,
                        child: Text(
                          "Progra Name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Hind',
                              letterSpacing: -1),
                        ),
                      ))),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.4,
                    height: 1,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8.5, right: 8.5),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'कलाकार: ',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'HIND',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    'भारत की लोकभारत...',
                                    style: TextStyle(
                                      color: const Color(0xFFFFFFFF)
                                          .withOpacity(0.8),
                                      fontFamily: 'HIND',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 22,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFA01B8A)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: BorderSide(
                                              color: const Color(0xFFFFFFFF)
                                                  .withOpacity(0.2))))),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xFFFFFFFF),
                                      size: 6,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Event Location",
                                      style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 7),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
