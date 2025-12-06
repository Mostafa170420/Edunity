import 'dart:math';

import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CourseTileWidget extends StatelessWidget {
  final CourseModel course;
  final bool completed;
  final bool isTeacher; // ✅ Add this parameter

  const CourseTileWidget({
    super.key,
    required this.course,
    this.completed = true,
    this.isTeacher = false, // ✅ Default to student
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              course.thumbnail ?? AppAssets.courseBackground,
              width: 100,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 40),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    course.category ?? "No Category",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    course.name ?? "No Name",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.darkColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.starSvg),
                      const Gap(3),
                      Text(
                        course.rating.toString(),
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        '|',
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Text(
                            '${getRandomStudentsCount()} ',
                            style: TextStyles.getSmall(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: AppColors.darkColor,
                            ),
                          ),
                          const Icon(
                            FontAwesome.user_group_solid,
                            size: 10,
                          )
                        ],
                      ),
                      const Gap(16),
                      Text(
                        '|',
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        course.duration ?? '0h 0m',
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  // ✅ Different bottom section based on user type
                  _buildBottomSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Build bottom section based on user type and completion status
  Widget _buildBottomSection() {
    if (isTeacher) {
      return _buildTeacherBottomSection();
    } else {
      return _buildStudentBottomSection();
    }
  }

  // ✅ STUDENT: Show progress bar or certificate
  Widget _buildStudentBottomSection() {
    if (completed) {
      // Student - Completed course: Show certificate
      return Expanded(
        child: InkWell(
          onTap: () {
            // TODO: Navigate to certificate
          },
          child: Row(
            children: [
              Text(
                "View Certificate",
                style: TextStyles.getSmall(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.greenColor,
                ).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.greenColor,
                  decorationThickness: 1.5,
                ),
                textAlign: TextAlign.end,
              ),
              const Spacer(),
              Icon(
                Icons.verified,
                color: AppColors.greenColor,
                size: 24,
              ),
            ],
          ),
        ),
      );
    } else {
      // Student - Ongoing course: Show progress bar
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearPercentIndicator(
              width: 145,
              lineHeight: 8,
              percent: course.progressPercent ?? 0,
              animation: true,
              backgroundColor: AppColors.borderColor,
              progressColor: AppColors.primaryDarkColor,
              barRadius: const Radius.circular(6),
              padding: EdgeInsets.zero,
              trailing: Text(
                ' ${((course.progressPercent ?? 0) * (course.numberOfVideos ?? 1)).toInt()} / ${course.numberOfVideos ?? 1}',
                style: TextStyles.getSmall(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: AppColors.darkColor,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  // ✅ TEACHER: Show manage/edit options or live status
  Widget _buildTeacherBottomSection() {
    if (completed) {
      // Teacher - Uploaded course: Show manage option
      return Expanded(
        child: InkWell(
          onTap: () {
            // TODO: Navigate to manage course
          },
          child: Row(
            children: [
              Text(
                "Manage Course",
                style: TextStyles.getSmall(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryDarkColor,
                ).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryDarkColor,
                  decorationThickness: 1.5,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.edit,
                color: AppColors.primaryDarkColor,
                size: 24,
              ),
            ],
          ),
        ),
      );
    } else {
      // Teacher - Live session: Show live indicator
      return Expanded(
        child: InkWell(
          onTap: () {
            // TODO: Navigate to live session
          },
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Live",
                      style: TextStyles.getSmall(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(
                Icons.play_circle_fill,
                color: Colors.red,
                size: 24,
              ),
            ],
          ),
        ),
      );
    }
  }
}

double getRandomProgress() {
  Random random = Random();
  return double.parse((random.nextDouble()).toStringAsFixed(2));
}

int getRandomStudentsCount() {
  return 100 + (DateTime.now().microsecond % 4900);
}
