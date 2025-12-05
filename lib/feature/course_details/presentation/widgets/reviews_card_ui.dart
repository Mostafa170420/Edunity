import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/course_details/data/model/reviews_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewsCardUI extends StatelessWidget {
  const ReviewsCardUI({super.key, required this.model});
  final ReviewsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.logoBackgroundColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.emptyUser,
                height: 50,
                width: 50,
              )
            ],
          ),
          Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.name,
                      style: TextStyles.getBody(fontSize: 16),
                    ),
                    Text("1 month"),
                  ],
                ),
                Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < model.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                Gap(15),
                Text(model.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
