import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:provider/provider.dart';

class ImageSlider extends StatefulWidget {
  final List<String?> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: 210, // Set the height here
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? Color(0xFF505050)
                        : Color(0xFFF0F0F0),
                  ),
                  child: url != null
                      ? Image.network(
                          url,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                height: 210,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${(loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) * 100).toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // return Image.asset(
                            //   'assets/EventHeader.jpg',
                            //   fit: BoxFit.cover,
                            // );
                            return const SizedBox(
                              child: Center(
                                  child: Text(
                                "Error Image",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              )),
                            );
                          },
                        )
                      // : Image.asset(
                      //     'assets/EventHeader.jpg',
                      //     fit: BoxFit.cover,
                      //   ),
                      : const SizedBox(
                          child: Center(
                              child: Text(
                            "No Image",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageUrls.asMap().entries.map((entry) {
            int index = entry.key;
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
