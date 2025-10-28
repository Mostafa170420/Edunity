import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/category_model.dart';
import 'package:edunity/feature/home/presentation/widgets/category_names_list.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.padding,
  });

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding,
          child: Row(
            children: [
              Hero(
                  tag: 'seeAllCategories',
                  child: Material(
                    color: Colors.transparent,
                    child: Text('Categories',
                        style: TextStyles.getTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    pushTo(context, Routes.category);
                  },
                  child: Text(
                    'SEE ALL >',
                    style: TextStyles.getBody(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDarkColor),
                  ))
            ],
          ),
        ),
        Gap(10),
        CustomHorizontalListView(
          height: 30,
          items: categories,
          itemBuilder: (context, category, index) {
            return CategoryNamesList(
              categoryNamesModel: categories[index],
            );
          },
        ),
      ],
    );
  }
}
