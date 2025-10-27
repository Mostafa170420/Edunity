import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key, required this.coursesModel});
  final CoursesNamesModel coursesModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context , constraints) {
        return Container(
          width: 280,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                
                child: Image.network(
                  
                  "https://www.emexotechnologies.com/wp-content/uploads/2024/05/Flutter-course-in-lucknow.png",
                  fit: BoxFit.cover,
                  height: constraints.maxHeight,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: constraints.maxHeight * 0.49,
                  // width: 250,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
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
                            icon: SvgPicture.asset(AppAssets.bookmarkOutline),
                            onPressed: () {},
                          )
                        ],
                      ),
                      // Gap(5),
                      Text(
                        coursesModel.title,
                        style: TextStyles.getBody(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Gap(10),
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
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
