import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.category_model});
  final CategoryModel category_model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(category_model.image),
        Gap(7),
        Text(category_model.name)
      ],
    );
  }
}
