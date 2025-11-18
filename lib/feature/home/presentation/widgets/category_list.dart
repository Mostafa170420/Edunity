import 'package:edunity/core/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(categoryModel.image),
        Gap(7),
        Text(categoryModel.name)
      ],
    );
  }
}
