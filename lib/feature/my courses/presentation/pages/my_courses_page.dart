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
  int currentIndex = 1; // 0: Completed, 1: Ongoing
  final searchController = TextEditingController();
  String searchText = '';
  List<CourseModel> completedCourses = [];
  List<CourseModel> ongoingCourses = [];

  List<Widget> screens = [];
  bool isLoading = true;

  String userType = SharedPref.getUserType(); // "student" or "teacher"
  String userId = SharedPref.getUserId();

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      log("Fetching student data...", name: "MyCourses");

      // Fetch student document
      var studentSnapshot = await FirebaseProvider.getStudentByID(userId);
      log("Student snapshot data: ${studentSnapshot.data()}",
          name: "MyCourses");

      // Extract course IDs
      var studentData = studentSnapshot.data() as Map<String, dynamic>;
      List<String> completedIds =
          List<String>.from(studentData['completedCourses'] ?? []);
      List<String> purchasedIds =
          List<String>.from(studentData['purchasedCourses'] ?? []);
      log("Completed IDs: $completedIds", name: "MyCourses");
      log("Purchased IDs: $purchasedIds", name: "MyCourses");

      if (completedIds.isEmpty && purchasedIds.isEmpty) {
        log("No course IDs found for this student.", name: "MyCourses");
      }

      // Fetch course documents from Firestore
      var completedSnapshot =
          await FirebaseProvider.getCoursesByIds(completedIds);
      var purchasedSnapshot =
          await FirebaseProvider.getCoursesByIds(purchasedIds);
      log("Completed courses docs count: ${completedSnapshot.docs.length}",
          name: "MyCourses");
      log("Purchased courses docs count: ${purchasedSnapshot.docs.length}",
          name: "MyCourses");

      // Map to CourseModel
      completedCourses = completedSnapshot.docs.map((doc) {
        var course = CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id);
        log("Completed course loaded: ${course.name}, id: ${course.id}",
            name: "MyCourses");
        return course.copyWith(completed: true, progressPercent: 1.0);
      }).toList();

      ongoingCourses = purchasedSnapshot.docs.map((doc) {
        var course = CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id);
        log("Ongoing course loaded: ${course.name}, id: ${course.id}",
            name: "MyCourses");
        return course.copyWith(
            completed: false, progressPercent: getRandomProgress());
      }).toList();

      log("Final completed courses list length: ${completedCourses.length}",
          name: "MyCourses");
      log("Final ongoing courses list length: ${ongoingCourses.length}",
          name: "MyCourses");

      // Update UI
      setState(() {
        isLoading = false;
      });
    } catch (e, stackTrace) {
      log("Error in loadCourses: $e",
          name: "MyCourses", error: e, stackTrace: stackTrace);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CourseModel> filteredCompleted = completedCourses
        .where((course) => course.name?.contains(searchText) ?? false)
        .toList();
    final List<CourseModel> filteredOngoing = ongoingCourses
        .where((course) => course.name?.contains(searchText) ?? false)
        .toList();
    log("Building UI with $searchText: "
        "${filteredCompleted.length} completed, ${filteredOngoing.length} ongoing");

    return Scaffold(
        appBar: AppBar(title: Text('My Courses')),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 60),
                child: Column(
                  children: [
                    // 1️⃣ Search box
                    CustomTextField(
                      controller: searchController,
                      onChanged: (p0) => setState(() {
                        searchText = p0.trim().toLowerCase();
                      }),
                      hintText: 'Search for..',
                      suffixIcon: GradientButton(
                        label: '',
                        onPressed: () {
                          setState(() {
                            searchText =
                                searchController.text.trim().toLowerCase();
                          });
                        },
                        width: 40,
                        borderRadius: 12,
                        icon: const Icon(IconlyBroken.search,
                            color: Colors.white),
                        iconAlignment: IconAlignment.end,
                      ),
                    ),
                    const Gap(20),

                    // 2️⃣ Buttons (Ongoing / Completed)
                    ChooseCoursesList(
                      selectedIndex: currentIndex,
                      onPressed: (value) {
                        setState(() {
                          currentIndex = value; // update which list is shown
                        });
                      },
                    ),
                    const Gap(10),

                    // 3️⃣ Courses list based on selected button

                    currentIndex == 0
                        ? CoursesListBuilder(courses: filteredCompleted)
                        : CoursesListBuilder(courses: filteredOngoing),
                  ],
                ),
              ));
  }
}
