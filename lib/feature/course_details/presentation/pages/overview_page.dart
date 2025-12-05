import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key, required this.course});
  final CourseModel course;

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    //Placeholder for actual course content from firebase or API
    List<String>? courseContent = widget.course.whatYouLearn;
    // Check if null or empty
    bool hasContent = courseContent != null && courseContent.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About this Course",
                style: TextStyles.getBody(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Gap(10),
              Text(widget.course.description ?? "N/A"),
              Gap(30),
              Text(
                "What you'll learn",
                style: TextStyles.getBody(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Gap(20),
              hasContent
                  ? ListView.builder(
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
                      })
                  : Center(
                      child: Text(
                        "N/A",
                        style: TextStyle(fontSize: 20),
                      ),
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
                      widget.course.level ?? "N/A",
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
                children: [
                  Text("Duration:"),
                  Text(widget.course.duration ?? "N/A")
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Language:"), Text("English")],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
