import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/category_model.dart';
import 'package:edunity/feature/home/presentation/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  var categorySearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'seeAllCategories',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'All Categories',
                style: TextStyles.getTitle(
                    fontWeight: FontWeight.bold, fontSize: 21),
              ),
            )),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            CustomTextField(
              controller: categorySearch,
              hintText: 'Search For..',
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppAssets.searchWithBackground)),
            ),
            Gap(60),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  var category = categories[index];
                  return CategoryList(categoryModel: category);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
