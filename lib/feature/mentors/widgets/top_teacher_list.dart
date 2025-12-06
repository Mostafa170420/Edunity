import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopTeacherList extends StatelessWidget {
  const TopTeacherList({super.key, required this.teacher});
  final TeacherModel teacher;

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
                backgroundImage: NetworkImage(
                  teacher.avatarUrl ?? '',
                ),
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.getBody(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      teacher.category ?? '',
                      style: TextStyles.getBody(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
