import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/bookmark/presentation/widgets/courses_categories_list.dart';
import 'package:edunity/feature/bookmark/presentation/widgets/courses_list_builder.dart';
import 'package:edunity/core/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'My Bookmark',
            style: TextStyles.getTitle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Gap(10),
              CoursesCategoriesList(courses: CoursesModel.courses),
              Gap(20),
              CoursesListBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
