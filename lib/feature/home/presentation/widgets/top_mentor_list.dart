import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopMentorList extends StatelessWidget {
  const TopMentorList({super.key, required this.mentor_model});
  final MentorModel mentor_model;

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
            child: Image.asset(
              mentor_model.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(7),
        Text(
          '${mentor_model.name}',
          style: TextStyles.getBody(fontSize: 13, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
