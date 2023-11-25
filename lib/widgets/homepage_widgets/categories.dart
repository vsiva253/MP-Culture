import 'package:flutter/material.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/widgets/profile_text.dart';

class RowWithCards extends StatelessWidget {
  final List<CatrgoryModel> categroy;
  const RowWithCards({super.key, required this.categroy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 15),
      child: Container(
        height: 69.0,
        // Height of the row
        child: Row(
          children: [
            WidgetsClass.buildItem('Image1', categroy[0].categoryHindi!,
                'assets/homepage/1.png', context, categroy),
            WidgetsClass.buildItem('Image2', categroy[1].categoryHindi!,
                'assets/homepage/2.png', context, categroy),
            WidgetsClass.buildItem('Image3', categroy[2].categoryHindi!,
                'assets/homepage/3.png', context, categroy),
            WidgetsClass.buildItem('Image4', categroy[3].categoryHindi!,
                'assets/homepage/4.png', context, categroy),
            WidgetsClass.buildItem('Image5', categroy[4].categoryHindi!,
                'assets/homepage/5.png', context, categroy),
            WidgetsClass.buildItem('Image6', categroy[5].categoryHindi!,
                'assets/homepage/6.png', context, categroy),
            WidgetsClass.buildItem('Image7', 'All Category',
                'assets/homepage/7.png', context, categroy),
          ],
        ),
      ),
    );
  }
}
