import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CourseCardUI extends StatelessWidget {
  const CourseCardUI({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(4),
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
                  const Gap(4),
                  Text(
                    "499/-",
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primaryLightColor,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.starSvg,
                        width: 14,
                        height: 14,
                      ),
                      const Gap(3),
                      Text(
                        "4.2",
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                      const Gap(12),
                      Text('|',
                          style: TextStyles.getSmall(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkColor)),
                      const Gap(12),
                      Text(
                        "12680 Std",
                        style: TextStyles.getSmall(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ],
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

class BookmarkIcon extends StatelessWidget {
  final VoidCallback onTap;
  const BookmarkIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            AppAssets.bookmarkFilledpng,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}