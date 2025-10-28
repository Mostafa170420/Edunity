import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_list.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_chips_list.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({
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
              Text('Polupar Courses',
                  style: TextStyles.getTitle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Spacer(),
              TextButton(
                  onPressed: () {},
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
        CoursesChipsList(
          coursesModel: CoursesModel.courses,
        ),
        Gap(10),
        CustomHorizontalListView(
          height: 230,
          items: CoursesModel.courses,
          courses: true,
          itemBuilder: (context, category, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: CoursesList(
                coursesModel: CoursesModel.courses[index + 1],
              ),
            );
          },
        ),
      ],
    );
  }
}
