import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/course_details/data/model/reviews_model.dart';
import 'package:edunity/feature/course_details/presentation/widgets/reviews_card_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Student Reviews:",
                      style: TextStyles.getBody(fontSize: 20),
                    )
                  ],
                ),
                Gap(20),
              ],
            ),
            Gap(25),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var reviewsVar = reviews[index];
                return ReviewsCardUI(model: reviewsVar);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: reviews.length,
            )
          ],
        ),
      ),
    );
  }
}
