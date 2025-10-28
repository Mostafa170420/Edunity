import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/category_model.dart';
import 'package:edunity/feature/home/presentation/widgets/search_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var Search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyles.getTitle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Hero(
              tag: 'searchFieldHero',
              child: Material(
                color: Colors.transparent,
                child: CustomTextField(
                  controller: Search,
                  hintText: 'Search For..',
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Image.asset(AppAssets.searchWithBackground)),
                ),
              ),
            ),
            Gap(30),
            Row(
              children: [
                Text('Recent Searches',
                    style: TextStyles.getTitle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'SEE ALL >',
                      style: TextStyles.getBody(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkColor),
                    ))
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Gap(15);
                },
                itemBuilder: (BuildContext context, int index) {
                  var search = categories[index];
                  return SearchList(category_model: search);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
