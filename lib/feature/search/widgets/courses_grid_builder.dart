import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CoursesGridBuilder extends StatelessWidget {
  const CoursesGridBuilder({
    super.key,
    required this.courses,
  });

  final List<CourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: courses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7, // adjust to make cards taller/shorter
      ),
      itemBuilder: (context, index) {
        final course = courses[index];
        return GestureDetector(
          onTap: () => pushTo(context, Routes.courseDetails, extra: course),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  Image.network(
                    course.thumbnail ?? AppAssets.placeholder,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 80, // adjust overlay height
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryLightColor.withValues(alpha: 0),
                            AppColors.primaryDarkColor.withValues(alpha: 0.6),
                            AppColors.primaryLightColor.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              ' ${course.category} ',
                              style: TextStyles.getSmall(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(200),
                                  fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            course.name ?? '',
                            style: TextStyles.getBody(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          Gap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.orangeColor, size: 16),
                                  Text(
                                    '${course.rating}',
                                    style: TextStyles.getBody(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                ],
                              ),
                              Text(
                                '\$49.99',
                                style: TextStyles.getBody(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
