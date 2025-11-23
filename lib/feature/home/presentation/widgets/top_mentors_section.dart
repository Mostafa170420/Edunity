import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/models/mentor_model.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:edunity/feature/home/presentation/widgets/mentor_names_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopMentorsSection extends StatelessWidget {
  const TopMentorsSection({
    super.key,
    required this.padding,
  });

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding,
          child: Row(
            children: [
              Hero(
                  tag: 'seeAllMentors',
                  child: Material(
                    color: Colors.transparent,
                    child: Text('Top Mentors',
                        style: TextStyles.getTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    pushTo(context, Routes.topMentors);
                  },
                  child: Text(
                    'SEE ALL >',
                    style: TextStyles.getBody(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDarkColor),
                  ))
            ],
          ),
        ),
        Gap(15),
        CustomHorizontalListView(
          height: 100,
          items: MentorModel.topMentors,
          itemBuilder: (context, category, index) {
            return MentorNamesList(
              mentorModel: MentorModel.topMentors[index],
            );
          },
        ),
      ],
    );
  }
}
