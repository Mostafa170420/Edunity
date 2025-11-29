import 'dart:developer';

import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
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
                'All Courses',
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
            Gap(30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 60,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    mainAxisExtent: 110),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  var category = categories[index];
                  for (var cat in categories) {
                    log('Category: ${cat.name}');
                  }

                  return GestureDetector(
                    onTap: () {
                      pushTo(context, Routes.categoryScreen,
                          extra: category.name);
                    },
                    child: Column(
                      children: [
                        Image.asset(category.image, height: 70, width: 80),
                        Gap(7),
                        Text(category.name)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
