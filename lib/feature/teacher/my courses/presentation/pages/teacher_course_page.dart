// Import necessary packages and widgets for the "My Courses" screen.
import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/model/student_user_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/teacher/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/teacher/my%20courses/presentation/widgets/courses_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class TeacherCoursePage extends StatefulWidget {
  const TeacherCoursePage({super.key});

  @override
  State<TeacherCoursePage> createState() => _TeacherCoursePageState();
}

class _TeacherCoursePageState extends State<TeacherCoursePage> {
  int currentIndex = 1;
  final searchController = TextEditingController();
  var student = fakeStudent;

  late final List<Widget> screens = [
    CoursesListBuilderTeacher(
      courses: student.enrolledCourses
          .where((course) => course.completed == true)
          .toList(),
    ),
    CoursesListBuilderTeacher(
      courses: student.enrolledCourses
          .where((course) => course.completed == false)
          .toList(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Courses',
          style: TextStyles.getTitle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkgreyColor,
          ),
        ),
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
            const Gap(20),
            ChooseCoursesListTeacher(
              selectedIndex: currentIndex,
              onPressed: (int value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            const Gap(10),
            screens[currentIndex],
            const Gap(100),
          ],
        ),
      ),
    );
  }
}
