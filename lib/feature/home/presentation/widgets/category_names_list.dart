import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryNamesList extends StatefulWidget {
  final CategoryModel category_names_model;

  CategoryNamesList({super.key, required this.category_names_model});

  @override
  State<CategoryNamesList> createState() => _CategoryNamesListState();
}

class _CategoryNamesListState extends State<CategoryNamesList> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Text(
        widget.category_names_model.name,
        style: isSelected
            ? TextStyles.getBody(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.primaryLightColor)
            : TextStyles.getBody(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColors.greyColor),
      ),
    );
  }
}
