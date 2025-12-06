import 'dart:developer';
import 'dart:math' hide log;

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int currentIndex = 1;
  final searchController = TextEditingController();

  bool isLoading = true;

  List<CourseModel> completedCourses = [];
  List<CourseModel> ongoingCourses = [];

  late String userType;
  late String userId;
  late bool isTeacher;

  @override
  void initState() {
    super.initState();
    _initAndLoad();
  }

  void _initAndLoad() {
    // Get user data
    userType = SharedPref.getUserType();
    userId = SharedPref.getUserId();

    // ✅ Check if teacher (case-insensitive + trim)
    isTeacher = userType.trim().toLowerCase() == 'teacher';

    // Debug logs
    log('userType: "$userType", isTeacher: $isTeacher');

    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      if (isTeacher) {
        // ========== TEACHER ==========
        var teacherSnapshot = await FirebaseProvider.getTeacherByID(userId);
        var teacherData = teacherSnapshot.data() as Map<String, dynamic>;

        // Live Sessions (ongoing)
        List<String> liveSessionIds =
            List<String>.from(teacherData['liveSessions'] ?? []);
        if (liveSessionIds.isNotEmpty) {
          var liveSnapshot =
              await FirebaseProvider.getCoursesByIds(liveSessionIds);
          ongoingCourses = liveSnapshot.docs.map((doc) {
            var course = CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            );
            return course.copyWith(completed: false);
          }).toList();
        }

        // Uploaded Courses (completed)
        List<String> uploadedIds =
            List<String>.from(teacherData['uploadedCourses'] ?? []);
        if (uploadedIds.isNotEmpty) {
          var uploadedSnapshot =
              await FirebaseProvider.getCoursesByIds(uploadedIds);
          completedCourses = uploadedSnapshot.docs.map((doc) {
            var course = CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            );
            return course.copyWith(completed: true);
          }).toList();
        }
      } else {
        // ========== STUDENT ==========
        var studentSnapshot = await FirebaseProvider.getStudentByID(userId);
        var studentData = studentSnapshot.data() as Map<String, dynamic>;

        // Purchased Courses (ongoing)
        List<String> purchasedIds =
            List<String>.from(studentData['purchasedCourses'] ?? []);
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
              progressPercent: _getRandomProgress(),
            );
          }).toList();
        }

        // Completed Courses
        List<String> completedIds =
            List<String>.from(studentData['completedCourses'] ?? []);
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
        }
      }

      setState(() => isLoading = false);
    } catch (e, stackTrace) {
      log("Error in loadCourses: $e",
          name: "MyCourses", error: e, stackTrace: stackTrace);
      setState(() => isLoading = false);
    }
  }

  double _getRandomProgress() {
    Random random = Random();
    return double.parse((random.nextDouble()).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Courses')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                      icon: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Dynamic button labels
                  ChooseCoursesList(
                    selectedIndex: currentIndex,
                    onPressed: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    firstLabel: isTeacher ? 'Live Sessions' : 'Ongoing',
                    secondLabel: isTeacher ? 'Uploaded Courses' : 'Completed',
                  ),
                  const SizedBox(height: 10),

                  // ✅ Pass isTeacher to list builder
                  currentIndex == 0
                      ? CoursesListBuilder(
                          courses: completedCourses,
                          isTeacher: isTeacher,
                        )
                      : CoursesListBuilder(
                          courses: ongoingCourses,
                          isTeacher: isTeacher,
                        ),
                ],
              ),
            ),
    );
  }
}
