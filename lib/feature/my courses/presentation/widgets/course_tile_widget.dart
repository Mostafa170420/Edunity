import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CourseTileWidget extends StatelessWidget {
  final CoursesModel course;
  final bool completed;
  const CourseTileWidget({
    super.key,
    required this.course,
    this.completed = true,
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
              course.imageUrl ?? AppAssets.courseBackground,
              width: 130,
              height: double.infinity,
              fit: BoxFit.cover,
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
                    course.category ?? "null Category",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    course.title,
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
                            '${course.studentsEnrolled ?? 0} ',
                            style: TextStyles.getSmall(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: AppColors.darkColor,
                            ),
                          ),
                          Icon(
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
                        '${course.totalDuration?.hour ?? 0}h ${course.totalDuration?.minute ?? 0}m',
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  completed
                      ? Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
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
                        )
                      : Expanded(
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
                                  ' ${((course.progressPercent ?? 0) * (course.lessonsCount ?? 1)).toInt()} / ${course.lessonsCount ?? 1}',
                                  style: TextStyles.getSmall(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                    color: AppColors.darkColor,
                                  ),
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
