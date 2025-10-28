import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:flutter/material.dart';

class CoursesChipsList extends StatefulWidget {
  final List<CoursesModel> coursesModel;

  const CoursesChipsList({super.key, required this.coursesModel});

  @override
  State<CoursesChipsList> createState() => _CoursesChipsListState();
}

class _CoursesChipsListState extends State<CoursesChipsList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return CustomHorizontalListView(
      height: 30,
      items: widget.coursesModel,
      itemBuilder: (context, item, index) {
        final bool isSelected = index == _selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? AppColors.primaryDarkColor
                  : AppColors.greyColor.withOpacity(0.2),
            ),
            child: Text(
              widget.coursesModel[index].title,
              style: TextStyles.getBody(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: isSelected ? AppColors.whiteColor : AppColors.greyColor),
            ),
          ),
        );
      },
    );
  }
}

