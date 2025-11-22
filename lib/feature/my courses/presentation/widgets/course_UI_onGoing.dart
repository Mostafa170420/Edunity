import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CoursesUIonGoing extends StatelessWidget {
  const CoursesUIonGoing({
    super.key,
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
            child: Image.asset(
              AppAssets.cardBackground,
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
                    "Category name",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    "Graphic Design",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.darkColor,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.starSvg),
                      const Gap(3),
                      Text(
                        "4.2",
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
                      Text(
                        "2 Hrs 36 Mins",
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LinearPercentIndicator(
                          width: 145,
                          lineHeight: 8,
                          percent: 0.8,
                          backgroundColor: AppColors.borderColor,
                          progressColor: AppColors.greenColor,
                          barRadius: const Radius.circular(6),
                          padding: EdgeInsets.zero,
                          progressBorderColor: AppColors.orangeColor,
                        ),
                        Spacer(),
                        Text(
                          "93/125s",
                          style: TextStyles.getSmall(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: AppColors.darkColor,
                          ),
                        ),
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
