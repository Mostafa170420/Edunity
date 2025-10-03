import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final CategoryModel category_model;

  CategoryList({required this.category_model});

  @override
  Widget build(BuildContext context) {
    return Text(
      category_model.title,
      style: TextStyles.getBody(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: AppColors.greyColor),
    );
  }
}
