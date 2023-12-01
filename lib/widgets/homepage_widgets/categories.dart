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
      child: SizedBox(
        height: 70,
        // Height of the row
        child: Row(
          children: [
            WidgetsClass.buildItem(
                themeProvider.isEnglish
                    ? categroy[0].category ?? "NA"
                    : categroy[0].categoryHindi ?? "NA",
                categroy[0].categoryIcon,
                context,
                categroy),
            WidgetsClass.buildItem(
                themeProvider.isEnglish
                    ? categroy[1].category ?? "NA"
                    : categroy[1].categoryHindi ?? "NA",
                categroy[1].categoryIcon,
                context,
                categroy),
            WidgetsClass.buildItem(
                themeProvider.isEnglish
                    ? categroy[2].category ?? "NA"
                    : categroy[2].categoryHindi ?? "NA",
                categroy[2].categoryIcon,
                context,
                categroy),
            WidgetsClass.buildItem(
                themeProvider.isEnglish
                    ? categroy[3].category ?? "NA"
                    : categroy[3].categoryHindi ?? "NA",
                categroy[3].categoryIcon,
                context,
                categroy),
            // WidgetsClass.buildItem(
            //     'Image5',
            //     themeProvider.isEnglish
            //         ? categroy[0].category ?? "NA"
            //         : categroy[0].categoryHindi ?? "NA",
            //     'assets/homepage/5.png',
            //     context,
            //     categroy),
            // WidgetsClass.buildItem(
            //     'Image6',
            //     themeProvider.isEnglish
            //         ? categroy[0].category ?? "NA"
            //         : categroy[0].categoryHindi ?? "NA",
            //     'assets/homepage/6.png',
            //     context,
            //     categroy),
            WidgetsClass.buildItem(StringValue.allCategory,
                'assets/homepage/7.png', context, categroy),
          ],
        ),
      ),
    );
  }
}
