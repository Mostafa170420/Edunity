import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MentorNamesList extends StatelessWidget {
  const MentorNamesList.teachersNamesList(
      {super.key, required this.teacherModel});
  final TeacherModel teacherModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              teacherModel.avatarUrl ?? AppAssets.defaultUser,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(7),
        Text(
          teacherModel.name ?? '',
          style: TextStyles.getBody(fontSize: 13, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
