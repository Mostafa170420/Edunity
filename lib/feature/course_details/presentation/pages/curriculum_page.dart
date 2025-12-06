import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/course_details/presentation/widgets/video_name_builder.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key, required this.course});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final int videoCount = course.videoNames?.length ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course content",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(16),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.logoBackgroundColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                course.name ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text("$videoCount lessons"),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: List.generate(videoCount, (index) {
                return VideoNameBuilder(
                  course: course,
                  index: index,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
