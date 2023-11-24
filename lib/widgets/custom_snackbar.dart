import 'dart:ui';

import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.fixed,
      // margin: EdgeInsets.only(
      //   bottom: MediaQuery.of(context).size.height - 100,
      //   left: 16,
      //   right: 16,
      // ),
    ),
  );
}

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: MediaQuery.of(context).size.height - 190,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 185, 5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Wait for some time and then remove the overlay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

// class CustomSnackbar {
//   static void show(BuildContext context, String message) {
//     OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//       builder: (BuildContext context) => Positioned(
//         bottom: MediaQuery.of(context).size.height - 150,
//         width: MediaQuery.of(context).size.width,
//         child: Material(
//           color: Colors.transparent,
//           child: Stack(
//             children: [
//               // Blur the background
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.2),
//                 ),
//               ),
//               // Your snackbar content
//               Container(
//                 alignment: Alignment.center,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 16.0),
//                   padding:
//                       EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: Text(
//                     message,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(overlayEntry);

//     // Wait for some time and then remove the overlay
//     Future.delayed(Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }
// }
