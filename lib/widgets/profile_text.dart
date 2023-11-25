import 'package:flutter/material.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/screens/categoryList/category_list_view.dart';
import 'package:mpc/screens/eventlist/category_academiec_event_list.dart';
import 'package:mpc/widgets/animation_page_route.dart';

class WidgetsClass {
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

  static Widget buildItem(String title, String name, String imagePath,
      BuildContext context, List<CatrgoryModel>? list) {
    return Expanded(
      child: SizedBox(
        width: 52,
        height: 69,
        child: GestureDetector(
          onTap: () {
            name == "All Category"
                ? Navigator.push(
                    context,
                    FadePageRoute(
                      builder: (context) =>
                          CategorysListView(categoryList: list!),
                    ))
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
                      color: Color(0xFF952766).withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: Color(0xFF952766).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          imagePath,
                          height: 34,
                          width: 34,
                          fit: BoxFit.contain, // Set the desired image height
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1, right: 1),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 8,
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
