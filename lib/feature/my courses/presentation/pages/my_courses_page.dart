import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder_completed.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder_onGoing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int currentIndex = 0;
  final searchController = TextEditingController();

  List<Widget> screens = [
    CoursesListBuilderCompleted(),
    CoursesListBuilderOnGoing(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'My Courses',
          style: TextStyles.getTitle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              hintText: 'Search for..',
              suffixIcon: Image.asset(AppAssets.searchBlue),
            ),
            Gap(20),
            ChooseCoursesList(
              selectedIndex: currentIndex,
              onPressed: (int value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            Gap(10),
            screens[currentIndex],
            Gap(100),
          ],
        ),
      ),
    );
  }
}
