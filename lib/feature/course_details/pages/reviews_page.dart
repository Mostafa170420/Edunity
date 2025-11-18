import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/course_details/model/reviews_model.dart';
import 'package:edunity/feature/course_details/widgets/reviews_card_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int ratingTotal = 4;
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
                      "Student \nReviews",
                      style: TextStyles.getBody(fontSize: 18),
                    )
                  ],
                ),
                Gap(20),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < ratingTotal ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        );
                      }),
                    ),
                    Text(
                      "4.9",
                      style: TextStyles.getBody(fontSize: 18),
                    )
                  ],
                ),
                Gap(20),
                Text("(324 Reviews)")
              ],
            ),
            Gap(20),
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
