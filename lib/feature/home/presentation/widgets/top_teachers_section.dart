import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:edunity/feature/home/presentation/widgets/mentor_names_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopTeachersSection extends StatelessWidget {
  const TopTeachersSection({
    super.key,
    required this.padding,
  });

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseProvider.sortTeacherByRating(),
        builder: (context, snapshot) {
          final teachers = snapshot.data?.docs.map((doc) {
                return TeacherModel.fromJson(
                    doc.data() as Map<String, dynamic>, doc.id);
              }).toList() ??
              [];
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
                              )),
                        )),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          pushTo(context, Routes.topMentors, extra: teachers);
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
                items: teachers,
                itemBuilder: (context, category, index) {
                  return GestureDetector(
                    onTap: () {
                      pushTo(context, Routes.teacherDetails,
                          extra: teachers[index]);
                    },
                    child: MentorNamesList.teachersNamesList(
                      teacherModel: teachers[index],
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}
