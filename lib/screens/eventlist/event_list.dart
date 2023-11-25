import 'package:flutter/material.dart';
import 'package:mpc/components/event_card.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventListView extends StatelessWidget {
  final String program;
  final List<EventData> eventList;
  const EventListView(
      {super.key, required this.eventList, required this.program});

  @override
  Widget build(BuildContext context) {
    print(eventList.length);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBarSecondary(),
        ),
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
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      program, //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
                      style: const TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                      colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: ListView.builder(
                      itemCount: (eventList.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        var event = eventList[index];
                        return Row(
                          children: [
                            Expanded(
                              child: EventCard(event: event),
                            ),
                            const SizedBox(
                                width: 8.0), // Adjust the spacing between cards
                            Expanded(
                              child: index * 2 + 1 < eventList.length
                                  ? EventCard(event: event)
                                  : Container(), // Check if the second item exists
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }
}
