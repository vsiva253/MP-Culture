import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  bool isDrawerOpen = true;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _showPreviousMonth() {
    setState(() {
      today = today.subtract(const Duration(days: 30));
    });
  }

  void _showNextMonth() {
    setState(() {
      today = today.add(const Duration(days: 30));
    });
  }

  String _getTitleDateFormat(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

  TextStyle txtStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  String _getDayAndDate(DateTime date) {
    return '${DateFormat.E().format(date)[0]}\n\n${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Calendar"),
      //   elevation: 2,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
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
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: isDrawerOpen ? 116 : 0,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF1D2671),
                                  Color(0xFFC33764),
                                  Colors.transparent,
                                ],
                                stops: [0.0, 1.0, 0.3],
                                transform: GradientRotation(
                                    125.32 * (3.141592653589793 / 180)),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      3.121,
                                  left: 16,
                                  right: 16,
                                  bottom: 50),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: MediaQuery.of(context).size.height /
                                        1.781,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                          0), // Customize the color as needed
                                      borderRadius: BorderRadius.circular(8),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0),
                                      //     spreadRadius: 2,
                                      //     blurRadius: 4,
                                      //     offset: Offset(0, 2),
                                      //   ),
                                      // ],
                                    ),
                                    // Add your scrollable content here
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount:
                                                10, // Replace with the number of cards you want
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                width: 80,
                                                height: 56,
                                                margin: const EdgeInsets.only(
                                                    bottom: 24),
                                                child: Card(
                                                  color: Colors.white,
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3,
                                                              bottom: 3),
                                                      child: Image.asset(
                                                        // Replace with the actual URL of your image
                                                        'assets/academies_header.jpg',
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SafeArea(
                              child: Container(
                                // color: Colors.orange,
                                height: double.infinity,
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width * 0.3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GradientText(
                                              "Calendar",
                                              style: const TextStyle(
                                                fontFamily: 'Hind',
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              colors: const [
                                                Color(0xFFC33764),
                                                Color(0xFF1D2671),
                                              ],
                                              stops: const [0.0, 1],
                                            ),
                                            // txtStyle.copyWith(
                                            //           fontSize: 22,
                                            //           fontWeight: FontWeight.w700),
                                            //     ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      DateFormat.EEEE().format(
                                                          DateTime.now()),
                                                      style: txtStyle,
                                                    ),
                                                    Text(
                                                      _getTitleDateFormat(
                                                          DateTime.now()),
                                                      style: txtStyle,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  DateTime.now().day.toString(),
                                                  style: txtStyle.copyWith(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GradientText(
                                          "संस्कृति संचालनालय",
                                          style: const TextStyle(
                                            fontFamily: 'Hind',
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          colors: const [
                                            Color(0xFFC33764),
                                            Color(0xFF1D2671),
                                          ],
                                          stops: const [0.0, 1],
                                        ),
                                        //  Text(
                                        //   "संस्कृति संचालनालय",
                                        //   style: TextStyle(
                                        //     fontSize: 22,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        height: 0,
                                      ),
                                      TableCalendar(
                                        firstDay: DateTime.utc(2000, 01, 01),
                                        focusedDay: today,
                                        lastDay: DateTime.utc(2040, 01, 01),
                                        availableGestures:
                                            AvailableGestures.all,
                                        calendarFormat: CalendarFormat.week,

                                        daysOfWeekStyle: DaysOfWeekStyle(
                                          dowTextFormatter: (date, locale) =>
                                              DateFormat.E().format(date)[0],
                                        ),
                                        daysOfWeekVisible:
                                            false, // to show week
                                        selectedDayPredicate: (DateTime? day) {
                                          return isSameDay(today, day!);
                                        },
                                        onDaySelected: _onDaySelected,
                                        rowHeight: 80,

                                        headerStyle: HeaderStyle(
                                          titleCentered: true,
                                          formatButtonVisible: false,
                                          leftChevronIcon: GestureDetector(
                                            onTap: _showPreviousMonth,
                                            child: Text(
                                              _getTitleDateFormat(
                                                today.subtract(
                                                  const Duration(days: 30),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          rightChevronIcon: GestureDetector(
                                            onTap: _showNextMonth,
                                            child: Text(
                                              _getTitleDateFormat(
                                                today.add(
                                                  const Duration(days: 30),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          titleTextFormatter: (date, locale) =>
                                              _getTitleDateFormat(date),
                                          titleTextStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        calendarStyle: const CalendarStyle(
                                          isTodayHighlighted: true,
                                          todayDecoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 52, 94, 4),
                                            shape: BoxShape.rectangle,
                                          ),
                                          selectedDecoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple,
                                                Colors.redAccent
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                        ),
                                        calendarBuilders: CalendarBuilders(
                                          todayBuilder:
                                              (context, day, focusedDay) =>
                                                  Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.purple,
                                                  Colors.red
                                                ],
                                                transform: GradientRotation(15),
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _getDayAndDate(day),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          outsideBuilder:
                                              (context, day, focusedDay) =>
                                                  SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _getDayAndDate(day),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          disabledBuilder:
                                              (context, day, focusedDay) =>
                                                  SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _getDayAndDate(day),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          defaultBuilder:
                                              (context, date, events) {
                                            return SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _getDayAndDate(date),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          selectedBuilder:
                                              (context, day, focusedDay) =>
                                                  Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.purple,
                                                  Colors.red
                                                ],
                                                transform: GradientRotation(15),
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _getDayAndDate(day),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount:
                                            5, // Replace with the number of cards you want
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: isDrawerOpen ? 10 : 30,
                                                right: 16,
                                                top: 16),
                                            child: Container(
                                                width: double.infinity,
                                                height: 121,
                                                margin: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  left: 10),
                                                          child: const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: const Text(
                                                              '09:30 \n10:30',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .pinkAccent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ))
                                                  ],
                                                )),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.99,
                  left: isDrawerOpen ? 99 : 0,
                  child: GestureDetector(
                    onTap: () {
                      print("Before: isDrawerOpen = $isDrawerOpen");
                      setState(() {
                        isDrawerOpen = !isDrawerOpen;
                      });
                      print("After: isDrawerOpen = $isDrawerOpen");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/polygon.png"),
                            colorFilter: ColorFilter.mode(
                                Color.fromARGB(255, 121, 21, 63)
                                    .withOpacity(0.2),
                                BlendMode.srcATop)),
                      ),
                      child: InkWell(
                        onTap: () {
                          print("Before: isDrawerOpen = $isDrawerOpen");
                          setState(() {
                            isDrawerOpen = !isDrawerOpen;
                          });
                          print("After: isDrawerOpen = $isDrawerOpen");
                        },
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isDrawerOpen = !isDrawerOpen;
                            });
                          },
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

bool isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
