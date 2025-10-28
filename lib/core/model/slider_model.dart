import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SliderModel extends StatelessWidget {
  const SliderModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(children: [
        Image.asset(AppAssets.cardBackground),
        Positioned(
          left: 22,
          right: 22,
          top: 12,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '25% Off*',
                  style: TextStyles.getTitle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.whiteColor),
                ),
                Text(
                  'Today’s Special',
                  style: TextStyles.getTitle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.whiteColor),
                ),
                Text(
                  'Get a Discount for Every Course Order only Valid for Today.!',
                  style: TextStyles.getTitle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
