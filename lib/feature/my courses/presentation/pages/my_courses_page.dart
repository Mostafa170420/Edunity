import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/model/student_user_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int currentIndex = 1;
  final searchController = TextEditingController();
  var student = fakeStudent;

  List<Widget> screens = [
    CoursesListBuilder(
      courses: fakeStudent.enrolledCourses
          .where((course) => course.completed == true)
          .toList(),
    ),
    CoursesListBuilder(
      courses: fakeStudent.enrolledCourses
          .where((course) => course.completed == false)
          .toList(),
    ),
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
              suffixIcon: GradientButton(
                  onPressed: () {},
                  label: '',
                  width: 40,
                  borderRadius: 12,
                  iconAlignment: IconAlignment.start,
                  icon: Icon(
                    IconlyBroken.search,
                    color: AppColors.whiteColor,
                  )),
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
