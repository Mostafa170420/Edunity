import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/course_UI_completed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoursesListBuilderCompleted extends StatelessWidget {
  const CoursesListBuilderCompleted({
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
        return Stack(
          clipBehavior: Clip.none,
          children: [
            CourseUICompleted(),
            Positioned(
              top: -14,
              right: 20,
              child: SvgPicture.asset(
                AppAssets.doneSvg,
                width: 32,
                height: 32,
              ),
            ),
          ],
        );
      },
    );
  }
}
