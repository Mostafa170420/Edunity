import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MentorNamesList extends StatelessWidget {
  const MentorNamesList({super.key, required this.mentorModel});
  final MentorModel mentorModel;

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
              mentorModel.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(7),
        Text(
          mentorModel.name,
          style: TextStyles.getBody(fontSize: 13, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
