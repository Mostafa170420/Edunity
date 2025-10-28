import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:edunity/core/model/mentor_model.dart';
import 'package:edunity/feature/mentors/widgets/top_mentor_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class TopMentorsScreen extends StatelessWidget {
  const TopMentorsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // var mentorSearch = TextEditingController();
    var topMentors = MentorModel.topMentors;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'seeAllMentors',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'Top Mentors',
                style: TextStyles.getTitle(
                    fontWeight: FontWeight.bold, fontSize: 21),
              ),
            )),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child:
                IconButton(onPressed: () {}, icon: Icon(IconlyBroken.search)),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: topMentors.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [Gap(20), Divider(), Gap(20)],
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  var mentor = topMentors[index];
                  var coursesNames = CoursesModel.courses[index + 1];
                  return TopMentorList(
                      mentor: mentor, coursesNamesModel: coursesNames);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
