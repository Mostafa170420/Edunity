// Import necessary packages and widgets for the "My Courses" screen.
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

/// The `MyCourses` widget is a stateful widget that displays the courses a student is enrolled in.
/// It separates courses into "Ongoing" and "Completed" lists.
class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  // `currentIndex` tracks the selected tab, where 1 is "Ongoing" and 0 is "Completed".
  int currentIndex = 1;
  final searchController = TextEditingController();

  // This uses a local, hardcoded student model. In a real application, this data
  // should be fetched from a repository or state management solution.
  var student = fakeStudent;

  // A list of widgets to display based on the selected tab.
  // Index 0: Completed courses.
  // Index 1: Ongoing courses.
  late final List<Widget> screens = [
    CoursesListBuilder(
      courses: student.enrolledCourses
          .where((course) => course.completed == true)
          .toList(),
    ),
    CoursesListBuilder(
      courses: student.enrolledCourses
          .where((course) => course.completed == false)
          .toList(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
        child: Column(
          children: [
            // A search field for filtering courses. Note: Search logic is not implemented.
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

            // A widget to toggle between "Ongoing" and "Completed" course lists.
            ChooseCoursesList(
              selectedIndex: currentIndex,
              onPressed: (int value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            const Gap(10),

            // Display the selected screen (Ongoing or Completed courses) based on `currentIndex`.
            screens[currentIndex],
            const Gap(
                100), // Provides extra space at the bottom of the scroll view.
          ],
        ),
      ),
    );
  }
}
