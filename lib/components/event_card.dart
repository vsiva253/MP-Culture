import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/screens/event_information.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatefulWidget {
  final EventData event;
  final bool isLive;
  // final bool fromLive;

  const EventCard({Key? key, required this.event, required this.isLive})
      : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLivegGoing = false;

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }

  void updateDisplayText() {
    DateTime startingDateTime = DateTime.parse(
        "${widget.event.startingDate} ${widget.event.startingTime}");
    DateTime endDateTime =
        DateTime.parse("${widget.event.endDate} ${widget.event.endTime}");
    DateTime currentDateTime = DateTime.now();

    if (currentDateTime.isAfter(startingDateTime) &&
        currentDateTime.isBefore(endDateTime)) {
      setState(() {
        isLivegGoing = true;
      });
    } else if (currentDateTime.isBefore(startingDateTime)) {
      setState(() {
        isLivegGoing = false;
      });
    } else {
      setState(() {
        isLivegGoing = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isLive) {
      updateDisplayText();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        updateDisplayText();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.isLive) {
          if (widget.event.programLink != null) {
            if (!await launchUrl(Uri.parse(widget.event.programLink!))) {
              throw Exception('Could not launch ');
            }
          } else {
            Navigator.push(
              context,
              FadePageRoute(
                builder: (context) => EventInformationScreen(
                  eventData: widget.event,
                ),
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            FadePageRoute(
              builder: (context) => EventInformationScreen(
                eventData: widget.event,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        height: 398,
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          elevation: 1,
          child: Column(
            children: [
              Stack(
                children: [
                  widget.event.profileImg != null
                      ? Image.network(
                          widget.event.profileImg ?? "NA",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // return Image.asset(
                            //   'assets/Event.jpg',
                            //   height: 180,
                            //   width: double.infinity,
                            //   fit: BoxFit.cover,
                            // );
                            return const SizedBox(
                                height: 180, width: double.infinity);
                          },
                        )
                      // : Image.asset(
                      //     'assets/Event.jpg',
                      //     height: 180,
                      //     width: double.infinity,
                      //     fit: BoxFit.cover,
                      //   ),
                      : const SizedBox(height: 180, width: double.infinity),
                  widget.isLive
                      ? isLivegGoing
                          ? Positioned(
                              top: 0,
                              left: 90,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.only(left: 1, top: 1),
                                height: 20,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFC33764),
                                      Color(0xFF1D2671),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Lottie.asset(
                                  'assets/live/live_txt.json', // Replace with the path to your Lottie animation file
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            )
                          : Positioned(
                              top: 0,
                              left: 90,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.only(left: 1, top: 1),
                                height: 12,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFC33764),
                                      Color(0xFF1D2671),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${formatDateString(widget.event.startingDate ?? "NA")} - ${formatDateString(widget.event.endDate ?? "NA")}',
                                    style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'HIND',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 6,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Positioned(
                          top: 0,
                          left: 90,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 1, top: 1),
                            height: 12,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFC33764),
                                  Color(0xFF1D2671),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${formatDateString(widget.event.startingDate ?? "NA")} - ${formatDateString(widget.event.endDate ?? "NA")}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'HIND',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 6,
                                ),
                              ),
                            ),
                          ),
                        ),
                  widget.isLive
                      ? isLivegGoing
                          ? const SizedBox()
                          : Positioned(
                              top: 12.2,
                              left: 90,
                              right: 0,
                              child: Container(
                                height: 12,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFC33764),
                                      Color(0xFF714ACF),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${widget.event.startingTime} - ${widget.event.endTime}',
                                    style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'HIND',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 6,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Positioned(
                          top: 12.2,
                          left: 90,
                          right: 0,
                          child: Container(
                            height: 12,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFC33764),
                                  Color(0xFF714ACF),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${widget.event.startingTime} - ${widget.event.endTime}',
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'HIND',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 6,
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
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Column(children: [
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xFFFFFFFF)
                                        .withOpacity(0.2)))),
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, bottom: 3, right: 5, left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.event.programName ?? "NA",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Hind',
                                            letterSpacing: 0),
                                      ),
                                    ),
                                    widget.event.programLink != null &&
                                            widget.isLive
                                        ? Lottie.asset(
                                            'assets/live/live_dot.json', // Replace with the path to your Lottie animation file
                                            width: 30,
                                            height: 30,
                                          )
                                        : const SizedBox()
                                  ],
                                )))),
                    // const Divider(
                    //   color: Colors.grey,
                    //   thickness: 0.3,
                    // ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 8.5, right: 8.5, top: 3),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${'kalakar'.tr()}: ",
                                      style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontFamily: 'HIND',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Text(
                                        // 'भारत की लोकभारत...',
                                        widget.event.artists != null
                                            ? "${widget.event.artists?[0].name}"
                                            : "NA",
                                        style: TextStyle(
                                          color: const Color(0xFFFFFFFF)
                                              .withOpacity(0.8),
                                          fontFamily: 'HIND',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${'entry'.tr()}: ",
                                      style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontFamily: 'HIND',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      widget.event.entryType ?? "NA",
                                      style: TextStyle(
                                        color: const Color(0xFFFFFFFF)
                                            .withOpacity(0.8),
                                        fontFamily: 'HIND',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
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
                            child: Center(
                                child: Text(
                              'organizer'.tr(),
                              style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'HIND',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )),
                          ),
                          Text(
                            widget.event.departmentBy ?? "NA",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF).withOpacity(0.7),
                              fontFamily: 'HIND',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 22,
                            width: 140,
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
                                        size: 10,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.event.city ?? "NA",
                                          // "ugfiuhsdiofhj hiohdioashj d",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 140,
                            height: 22,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    FadePageRoute(
                                      builder: (context) =>
                                          EventInformationScreen(
                                        eventData: widget.event,
                                      ),
                                    ));
                              },
                              style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.black.withOpacity(0.0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                      color: const Color(0xFFFFFFFF)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Show More',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
