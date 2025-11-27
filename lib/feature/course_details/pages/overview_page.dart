import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    //Placeholder for actual course content from firebase or API
    List<String> courseContent = [
      "Master Differential and Integral Calculus",
      "Solve Complex Mathematical problems with confidence",
      "Apply calculus to real-world scenarios",
      "Prepare for advanced mathematics courses",
      "Build strong problem-solving skills "
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About this Course",
              style:
                  TextStyles.getBody(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Text("Master the fundamentals and advanced concepts of "
                    "calculus with hands-on practice and real-world applications."
                    "Perfect for students preparing for exams or " +
                "looking to strengthen their mathematical foundation."),
            Gap(30),
            Text(
              "What you'll learn",
              style:
                  TextStyles.getBody(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Gap(20),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: courseContent.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.task_alt,
                        color: Colors.green,
                      ),
                      title: Text(courseContent[index]),
                    );
                  }),
            ),
            Gap(25),
            Text(
              "Course Details",
              style: TextStyles.getBody(fontSize: 18),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Level:"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.whiteColor, width: 1)),
                  child: Text(
                    "Intermediate",
                    style: TextStyle(
                        color: AppColors.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Duration:"), Text("12 Hours")],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Language:"), Text("English")],
            ),
          ],
        ),
      ),
    );
  }
}
