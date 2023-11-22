import 'package:flutter/material.dart';

class SkeletonList extends StatelessWidget {
  final int itemCount;

  const SkeletonList({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 206.0, // Set the desired height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 300.0,
            margin: EdgeInsets.only(left: 41.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border(bottom: BorderSide(color: Color(0xFF1E1E1E)))
                // boxShadow: [
                //   BoxShadow(
                //     color: Color(0xFF1E1E1E),
                //     offset: Offset(-4.0, 2.0),
                //     blurRadius: 12.0,
                //   ),
                // ],

                // color: Color(
                //     0xFF1E1E1E), // You can change the background color to your liking
                ),
            // child: Image.asset("assets/image1.jpg", fit: BoxFit.cover),
            // Adjust the spacing between items
          );
        },
      ),
    );
  }
}
