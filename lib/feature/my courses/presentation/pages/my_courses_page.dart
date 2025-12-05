// Import necessary packages and widgets for the "My Courses" screen.
import 'dart:developer';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/course_tile_widget.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder.dart';
import 'package:flutter/material.dart';

/// The `MyCourses` widget is a stateful widget that displays the courses a student is enrolled in.
/// It separates courses into "Ongoing" and "Completed" lists.
class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int currentIndex = 1; // 0: Completed, 1: Ongoing
  final searchController = TextEditingController();

  bool isLoading = true;

  List<CourseModel> completedCourses = [];
  List<CourseModel> ongoingCourses = [];

  String userType = SharedPref.getUserType(); // "student" or "teacher"
  String userId = SharedPref.getUserId();

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      // Fetch student data
      var studentSnapshot = await FirebaseProvider.getStudentByID(userId);
      var studentData = studentSnapshot.data() as Map<String, dynamic>;
      List<String> completedIds =
          List<String>.from(studentData['completedCourses'] ?? []);
      List<String> purchasedIds =
          List<String>.from(studentData['purchasedCourses'] ?? []);

      // ✅ Only fetch completed courses if IDs exist
      if (completedIds.isNotEmpty) {
        var completedSnapshot =
            await FirebaseProvider.getCoursesByIds(completedIds);
        completedCourses = completedSnapshot.docs.map((doc) {
          var course = CourseModel.fromJson(
            doc.data() as Map<String, dynamic>,
            id: doc.id,
          );
          return course.copyWith(completed: true, progressPercent: 1.0);
        }).toList();
      } else {
        completedCourses = []; // Explicitly set to empty
      }

      // ✅ Only fetch ongoing courses if IDs exist
      if (purchasedIds.isNotEmpty) {
        var purchasedSnapshot =
            await FirebaseProvider.getCoursesByIds(purchasedIds);
        ongoingCourses = purchasedSnapshot.docs.map((doc) {
          var course = CourseModel.fromJson(
            doc.data() as Map<String, dynamic>,
            id: doc.id,
          );
          return course.copyWith(
            completed: false,
            progressPercent: getRandomProgress(),
          );
        }).toList();
      } else {
        ongoingCourses = []; // Explicitly set to empty
      }

      setState(() => isLoading = false);
    } catch (e, stackTrace) {
      log("Error in loadCourses: $e",
          name: "MyCourses", error: e, stackTrace: stackTrace);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Courses')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 60),
              child: Column(
                children: [
                  // Search box
                  CustomTextField(
                    controller: searchController,
                    hintText: 'Search for..',
                    suffixIcon: GradientButton(
                      onPressed: () {},
                      label: '',
                      width: 40,
                      borderRadius: 12,
                      iconAlignment: IconAlignment.start,
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons (Ongoing / Completed)
                  ChooseCoursesList(
                    selectedIndex: currentIndex,
                    onPressed: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Render the currently selected list only
                  currentIndex == 0
                      ? CoursesListBuilder(courses: completedCourses)
                      : CoursesListBuilder(courses: ongoingCourses),
                ],
              ),
            ),
    );
  }
}
