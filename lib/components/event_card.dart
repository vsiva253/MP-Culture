import 'package:flutter/material.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/screens/event_information.dart';
import 'package:mpc/widgets/animation_page_route.dart';

class EventCard extends StatefulWidget {
  final EventData event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5163,
      width: MediaQuery.of(context).size.width / 2.46,
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/Event.jpg',
                  height: 182.86,
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
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        '${widget.event.startingDate} - ${widget.event.endDate}',
                        style: TextStyle(
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
                        '${widget.event.startingTime} - ${widget.event.endTime}',
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
                  Container(
                      height: 15.12,
                      width: double.infinity,
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'उत्कर्ष',
                          style: TextStyle(
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
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8.5, right: 8.5),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
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
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'प्रवेश: ',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'HIND',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    widget.event.entryType == "Free"
                                        ? 'पहले आये पहले पाए'
                                        : widget.event.entryType!,
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
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 17.5, right: 17.5),
                          width: double.infinity,
                          child: const Center(
                              child: Text(
                            'आयोजक ',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'HIND',
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          )),
                        ),
                        Text(
                          widget.event.programName!,
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF).withOpacity(0.7),
                            fontFamily: 'HIND',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
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
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xFFFFFFFF),
                                      size: 6,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      widget.event.state!,
                                      style: TextStyle(
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
                        Container(
                          width: 80,
                          height: 22,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                    builder: (context) =>
                                        EventInformationScreen(),
                                  ));
                            },
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.black.withOpacity(0.0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color: const Color(0xFFFFFFFF)
                                                .withOpacity(0.2))))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Show More',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
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
