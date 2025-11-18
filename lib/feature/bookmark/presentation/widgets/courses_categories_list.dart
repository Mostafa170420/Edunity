import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:flutter/material.dart';

class CoursesCategoriesList extends StatefulWidget {
  final List<CoursesModel> courses;
  const CoursesCategoriesList({super.key, required this.courses});

  @override
  State<CoursesCategoriesList> createState() => _CoursesCategoriesListState();
}

class _CoursesCategoriesListState extends State<CoursesCategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final course = widget.courses[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected
                    ? AppColors.greenColor
                    : AppColors.greyColor.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Text(
                  course.title,
                  style: TextStyles.getBody(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: isSelected ? Colors.white : AppColors.greyColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
