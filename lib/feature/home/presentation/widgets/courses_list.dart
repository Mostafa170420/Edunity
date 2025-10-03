import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key, required this.courses_model});
  final CoursesNamesModel courses_model;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(AppAssets.courseBackground),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 100,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(22)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'course type',
                          style: TextStyles.getBody(
                              color: AppColors.orangeColor, fontSize: 14),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Image.asset(AppAssets.bookmark),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Gap(5),
                    Text(
                      '${courses_model.title}',
                      style: TextStyles.getBody(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '850\$  ',
                          style: TextStyles.getBody(
                              color: AppColors.primaryLightColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.star,
                                color: AppColors.yellowDarkColor,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              '4.2 ',
                              style: TextStyles.getBody(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          '7830 Std',
                          style: TextStyles.getBody(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
