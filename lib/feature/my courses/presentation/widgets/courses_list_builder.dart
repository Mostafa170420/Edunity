import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/course_tile_widget.dart';
import 'package:flutter/material.dart';

class CoursesListBuilder extends StatelessWidget {
  final List<CourseModel> courses; // <- change CoursesModel to CourseModel
  const CoursesListBuilder({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      separatorBuilder: (_, __) => const SizedBox(height: 30),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseTileWidget(
          course: courses[index],
          completed: courses[index].completed,
        );
      },
    );
  }
}
