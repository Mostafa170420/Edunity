import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/course_model.dart';
import 'package:edunity/feature/home/presentation/model/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopMentorList extends StatelessWidget {
  const TopMentorList(
      {super.key, required this.mentorModel, required this.coursesNamesModel});
  final MentorModel mentorModel;
  final CoursesModel coursesNamesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(
                  mentorModel.image,
                ),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mentorModel.name,
                    style: TextStyles.getBody(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    coursesNamesModel.title,
                    style: TextStyles.getBody(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
