import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/course_tile_widget.dart';
import 'package:flutter/material.dart';

class CoursesListBuilder extends StatelessWidget {
  final List<CourseModel> courses;

  const CoursesListBuilder({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Container(
        height: 300, // give some fixed height so layout is preserved
        alignment: Alignment.center,
        child: Text(
          'No courses available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
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
