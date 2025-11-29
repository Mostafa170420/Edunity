import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/mentors/widgets/top_teacher_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class TopteachersScreen extends StatelessWidget {
  const TopteachersScreen({super.key, required this.teachers});
  final List<TeacherModel> teachers;
  @override
  Widget build(BuildContext context) {
    // var mentorSearch = TextEditingController();
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
                itemCount: teachers.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [Gap(20), Divider(), Gap(20)],
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return TopTeacherList(teacher: teachers[index]);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
