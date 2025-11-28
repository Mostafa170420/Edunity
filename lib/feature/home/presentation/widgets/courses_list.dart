import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => pushTo(context, Routes.courseDetails, extra: course),
          child: SizedBox(
            width: 300,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    course.thumbnail ?? AppAssets.placeholder,
                    fit: BoxFit.cover,
                    width: 300,
                    height: constraints.maxHeight,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: constraints.maxHeight * 0.32,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryLightColor.withOpacity(0),
                          AppColors.primaryDarkColor.withOpacity(0.6),
                          AppColors.primaryLightColor.withOpacity(0.8),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkgreyColor.withAlpha(100),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.darkgreyColor.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                course.category ?? '',
                                style: TextStyles.getSmall(
                                  color: AppColors.whiteColor.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // const SizedBox(width: 10),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 6),

                        //Title
                        Text(
                          course.name ?? '',
                          style: TextStyles.getBody(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRaiting(),
                            _buildStudentNum(),
                            _buildPrice()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        IconlyLight.bookmark,
                        color: AppColors.whiteColor,
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _buildRaiting() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: AppColors.orangeColor,
          size: 20,
        ),
        Text(
          '${course.rating}',
          style: TextStyles.getBody(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Text _buildPrice() {
    return Text.rich(
      TextSpan(
          text: '\$',
          style: TextStyles.getBody(
            color: AppColors.whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '49.99',
              style: TextStyles.getBody(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }

  Row _buildStudentNum() {
    return Row(
      spacing: 5,
      children: [
        Icon(
          FontAwesome.user_group_solid,
          size: 12,
          color: AppColors.whiteColor,
        ),
        Text(
          '\$1.2k',
          style: TextStyles.getBody(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
