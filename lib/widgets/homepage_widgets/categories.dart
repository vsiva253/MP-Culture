import 'package:flutter/material.dart';

class RowWithCards extends StatelessWidget {
  const RowWithCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 15),
      child: Container(
        height: 69.0,
        // Height of the row
        child: Row(
          children: [
            buildItem('Image1', 'Drama', 'assets/homepage/1.png', () {
              // Add your logic for onTap on Card 1
              print('Tapped on Card 1');
            }),
            buildItem('Image2', 'Modern Art', 'assets/homepage/2.png', () {
              // Add your logic for onTap on Card 2
              print('Tapped on Card 2');
            }),
            buildItem('Image3', 'Light Music', 'assets/homepage/3.png', () {
              // Add your logic for onTap on Card 3
              print('Tapped on Card 3');
            }),
            buildItem('Image4', 'Tribal', 'assets/homepage/4.png', () {
              // Add your logic for onTap on Card 4
              print('Tapped on Card 4');
            }),
            buildItem('Image5', 'Classical', 'assets/homepage/5.png', () {
              // Add your logic for onTap on Card 5
              print('Tapped on Card 5');
            }),
            buildItem('Image6', 'Folk', 'assets/homepage/6.png', () {
              // Add your logic for onTap on Card 6
              print('Tapped on Card 6');
            }),
            buildItem('Image7', 'All Category', 'assets/homepage/7.png', () {
              // Add your logic for onTap on Card 7
              print('Tapped on Card 7');
            }),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      String title, String name, String imagePath, VoidCallback? onTap) {
    return Expanded(
      child: Container(
        width: 52,
        height: 69,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                width: 52,
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
