import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:edunity/feature/home/presentation/model/mentor_model.dart';
import 'package:edunity/feature/home/presentation/widgets/search_list.dart';
import 'package:edunity/feature/home/presentation/widgets/top_mentor_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopMentorsScreen extends StatelessWidget {
  TopMentorsScreen({super.key});
  var mentorSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            child: IconButton(
                onPressed: () {}, icon: Image.asset(AppAssets.search)),
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
                itemCount: mentors.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [Gap(20), Divider(), Gap(20)],
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  var mentor = mentors[index];
                  var coursesNames = courses[index + 1];
                  return TopMentorList(
                      mentorModel: mentor, coursesNamesModel: coursesNames);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
