import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/components/event_card.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/screens/eventlist/event_list.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventListCard extends StatelessWidget {
  final String program;
  final bool ShowProgram;
  final List<EventData> eventList;
  const EventListCard(
      {super.key,
      required this.eventList,
      required this.program,
      required this.ShowProgram});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    program, // "Today Program", //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                    style: const TextStyle(
                      fontFamily: 'Hind',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                    colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                  ),
                  eventList.length >= 5
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    builder: (BuildContext context) =>
                                        EventListView(
                                          eventList: eventList,
                                          program: program,
                                          ShowProgram: true,
                                        )));
                          },
                          child: GradientText(
                            "View all", //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                            style: const TextStyle(
                              fontFamily: 'Hind',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                            colors: const [
                              Color(0xFFC33764),
                              Color(0xFF1D2671)
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        !(ShowProgram)
            ? eventList.isEmpty
                ? const Center(child: Text("Events are not availables"))
                : Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: 368,
                    // Set the height according to your needs
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventList.length >= 5 ? 5 : eventList.length,
                      itemBuilder: (context, index) {
                        final event = eventList[index];
                        return EventCard(
                          event: event,
                        );
                      },
                    ),
                  )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Please login to view this Program List'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPreferencesScreen()),
                        );
                      },
                      child: Text('login'.tr()),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
