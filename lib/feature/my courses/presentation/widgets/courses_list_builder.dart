import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/course_tile_widget.dart';
import 'package:flutter/material.dart';

class CoursesListBuilder extends StatelessWidget {
  final List<CourseModel> courses;
  final bool isTeacher; // ✅ Add this parameter

  const CoursesListBuilder({
    super.key,
    required this.courses,
    this.isTeacher = false, // ✅ Default to student
  });

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Container(
        height: 300,
        alignment: Alignment.center,
        child: const Text(
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
          isTeacher: isTeacher, // ✅ Pass the user type
        );
      },
    );
  }
}
