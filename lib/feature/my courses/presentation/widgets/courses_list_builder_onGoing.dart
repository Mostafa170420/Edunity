import 'package:edunity/feature/my%20courses/presentation/widgets/course_UI_onGoing.dart';
import 'package:flutter/material.dart';

class CoursesListBuilderOnGoing extends StatelessWidget {
  const CoursesListBuilderOnGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      separatorBuilder: (_, __) => const SizedBox(height: 30),
      itemCount: 5,
      itemBuilder: (context, index) {
        return CoursesUIonGoing();
      },
    );
  }
}
