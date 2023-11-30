import 'package:flutter/material.dart';
import 'package:mpc/components/theme_data.dart';
import 'package:mpc/data/models/category_model.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/widgets/profile_text.dart';
import 'package:provider/provider.dart';

class RowWithCards extends StatelessWidget {
  final List<CatrgoryModel> categroy;
  const RowWithCards({super.key, required this.categroy});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 15),
      child: Container(
        height: 69.0,
        // Height of the row
        child: Row(
          children: [
            WidgetsClass.buildItem(
                'Image1',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/1.png',
                context,
                categroy),
            WidgetsClass.buildItem(
                'Image2',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/2.png',
                context,
                categroy),
            WidgetsClass.buildItem(
                'Image3',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/3.png',
                context,
                categroy),
            WidgetsClass.buildItem(
                'Image4',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/4.png',
                context,
                categroy),
            WidgetsClass.buildItem(
                'Image5',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/5.png',
                context,
                categroy),
            WidgetsClass.buildItem(
                'Image6',
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                'assets/homepage/6.png',
                context,
                categroy),
            WidgetsClass.buildItem('Image7', StringValue.allCategory,
                'assets/homepage/7.png', context, categroy),
          ],
        ),
      ),
    );
  }
}
