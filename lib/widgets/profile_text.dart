import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/screens/eventlist/category_academiec_event_list.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:provider/provider.dart';

class WidgetsClass {
  static TextStyle style = const TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Hind',
      letterSpacing: 0);

  static Widget noImageAvalble() {
    return Container(
      color: Colors.grey,
      height: 180,
      width: double.infinity,
    );
  }

  static Widget txt(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 1),
      child: Row(
        children: [
          Text("$key :\t",
              maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
          Expanded(
            flex: 2,
            child: Text(
              value,
              maxLines: 1,
              // textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: style.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  static Widget TextW(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            value,
            style: const TextStyle(fontSize: 17),
          ),
        ),
        const Divider(thickness: 1),
        const SizedBox(height: 8),
      ],
    );
  }

  static Widget buildItem(String name, String? imagePath, BuildContext context,
      List<CatrgoryModel>? list) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Expanded(
      child: SizedBox(
        width: 52,
        // height: 69,
        child: GestureDetector(
          onTap: () {
            name == "All Category" || name == "सभी श्रेणियाँ"
                ? showDialog(
                    context: context,
                    builder: (context) {
                      if (list == null || list.isEmpty) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          title: Text(name),
                          content: const Text('No categories available.'),
                        );
                      }

                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: 320,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5),
                          child: ListView.builder(
                            itemCount: ((list.length) / 3).ceil(),
                            itemBuilder: (context, index) {
                              var startIndex = index * 3;
                              var endIndex = (startIndex + 3) < list.length
                                  ? (startIndex + 3)
                                  : list.length;

                              var itemsToDisplay =
                                  list.sublist(startIndex, endIndex);

                              return SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (var item in itemsToDisplay)
                                      WidgetsClass.buildItem(
                                        themeProvider.isEnglish
                                            ? item.category ?? "NA"
                                            : item.categoryHindi ?? "NA",
                                        item.categoryIcon,
                                        context,
                                        [],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Navigator.push(
                    context,
                    FadePageRoute(
                      builder: (context) =>
                          ByCategoryEventListView(program: name),
                    ));
          },
          child: Column(
            children: [
              Container(
                width: 50,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF952766).withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF952766).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.all(3),
                          child:
                              name == "All Category" || name == "सभी श्रेणियाँ"
                                  ? Center(
                                      child: Image.asset(
                                        'assets/homepage/7.png',
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : imagePath != null
                                      ? Image.network(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/homepage/1.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.network(
                                          'assets/homepage/1.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/homepage/1.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1, // Display text in a single line
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis if text overflows
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
