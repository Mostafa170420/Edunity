import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/category_model.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.category_model});
  final CategoryModel category_model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          category_model.name,
          style: TextStyles.getBody(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.greyColor.withValues(alpha: 0.6)),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.close,
            color: AppColors.greyColor.withValues(alpha: 0.6),
          ),
        )
      ],
    );
  }
}
