import 'package:flutter/material.dart';
import 'package:mpc/components/event_card.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ByCategoryEventListView extends StatefulWidget {
  final String program;

  const ByCategoryEventListView({super.key, required this.program});

  @override
  State<ByCategoryEventListView> createState() =>
      _ByCategoryEventListViewState();
}

class _ByCategoryEventListViewState extends State<ByCategoryEventListView> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeViewModel>()
        .fetchProgramsByCagegory(context, widget.program);
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBarSecondary(),
        ),
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
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          widget
                              .program, //"वर्तमान मैं संचालित हो रहे कार्यक्रम",
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
                    homeViewModel.byCategoreyProgramList.isEmpty
                        ? const Center(
                            child: Text("Evetes are Not Avabile"),
                          )
                        : Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: ListView.builder(
                                itemCount: (homeViewModel
                                            .byCategoreyProgramList.length /
                                        2)
                                    .ceil(),
                                itemBuilder: (context, index) {
                                  var firstEventIndex = index * 2;
                                  var secondEventIndex = index * 2 + 1;

                                  return SizedBox(
                                    height: 375,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: EventCard(
                                            event: homeViewModel
                                                    .byCategoreyProgramList[
                                                firstEventIndex],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ), // Adjust the spacing between cards
                                        Expanded(
                                          child: secondEventIndex <
                                                  homeViewModel
                                                      .byCategoreyProgramList
                                                      .length
                                              ? EventCard(
                                                  event: homeViewModel
                                                          .byCategoreyProgramList[
                                                      secondEventIndex])
                                              : const SizedBox(), // Check if the second item exists
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                  ])
                ],
              ));
  }
}
