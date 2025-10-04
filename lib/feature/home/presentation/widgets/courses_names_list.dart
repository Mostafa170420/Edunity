import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:flutter/material.dart';

class CoursesNamesList extends StatefulWidget {
  final CoursesNamesModel courses_model;

  CoursesNamesList({required this.courses_model});

  @override
  State<CoursesNamesList> createState() => _CoursesNamesListState();
}

class _CoursesNamesListState extends State<CoursesNamesList> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primaryLightColor
              : AppColors.greyColor.withValues(alpha: 0.2),
        ),
        child: Text(
          widget.courses_model.title,
          style: TextStyles.getBody(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: isSelected ? AppColors.whiteColor : AppColors.greyColor),
        ),
      ),
    );
  }
}
