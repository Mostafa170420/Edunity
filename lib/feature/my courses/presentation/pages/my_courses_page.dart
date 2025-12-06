import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/choose_courses_list.dart';
import 'package:edunity/feature/my%20courses/presentation/widgets/courses_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int currentIndex = 1;
  final searchController = TextEditingController();
  String searchText = '';
  List<CourseModel> completedCourses = [];
  List<CourseModel> ongoingCourses = [];

  bool isLoading = true;

  late String userType;
  late String userId;
  late bool isTeacher;

  // ✅ Stream subscription to listen for changes
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  @override
  void initState() {
    super.initState();
    _initAndListen();
  }

  @override
  void dispose() {
    // ✅ Cancel subscription when widget is disposed
    _userSubscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _initAndListen() {
    userType = SharedPref.getUserType();
    userId = SharedPref.getUserId();
    isTeacher = userType.trim().toLowerCase() == 'teacher';

    log('userType: "$userType", isTeacher: $isTeacher');

    // ✅ Start listening to real-time changes
    _listenToUserChanges();
  }

  void _listenToUserChanges() {
    // ✅ Get the appropriate collection based on user type
    final collection = isTeacher
        ? FirebaseFirestore.instance.collection('Teacher')
        : FirebaseFirestore.instance.collection('Student');

    // ✅ Listen to user document changes
    _userSubscription = collection.doc(userId).snapshots().listen(
      (snapshot) {
        if (snapshot.exists) {
          log('🔄 Detected change in Firestore!');
          _processUserData(snapshot.data() as Map<String, dynamic>);
        }
      },
      onError: (error) {
        log('Error listening to changes: $error');
        setState(() => isLoading = false);
      },
    );
  }

  Future<void> _processUserData(Map<String, dynamic> userData) async {
    try {
      if (isTeacher) {
        await _loadTeacherCourses(userData);
      } else {
        await _loadStudentCourses(userData);
      }

      setState(() => isLoading = false);
    } catch (e, stackTrace) {
      log("Error processing user data: $e",
          name: "MyCourses", error: e, stackTrace: stackTrace);
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadTeacherCourses(Map<String, dynamic> teacherData) async {
    // Live Sessions (ongoing)
    List<String> liveSessionIds =
        List<String>.from(teacherData['liveSessions'] ?? []);

    if (liveSessionIds.isNotEmpty) {
      var liveSnapshot = await FirebaseProvider.getCoursesByIds(liveSessionIds);
      ongoingCourses = liveSnapshot.docs.map((doc) {
        var course = CourseModel.fromJson(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
        return course.copyWith(completed: false);
      }).toList();
    } else {
      ongoingCourses = [];
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
    } else {
      completedCourses = [];
    }

    log('Teacher - Live: ${ongoingCourses.length}, Uploaded: ${completedCourses.length}');
  }

  Future<void> _loadStudentCourses(Map<String, dynamic> studentData) async {
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
    } else {
      ongoingCourses = [];
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
    } else {
      completedCourses = [];
    }

    log('Student - Ongoing: ${ongoingCourses.length}, Completed: ${completedCourses.length}');
  }

  double _getRandomProgress() {
    Random random = Random();
    return double.parse((random.nextDouble()).toStringAsFixed(2));
  }

  // ✅ Manual refresh option (pull to refresh)
  Future<void> _refreshCourses() async {
    setState(() => isLoading = true);
    // The stream will automatically trigger _processUserData
    // But we can force a refresh by re-reading the document
    final collection = isTeacher
        ? FirebaseFirestore.instance.collection('Teacher')
        : FirebaseFirestore.instance.collection('Student');

    final snapshot = await collection.doc(userId).get();
    if (snapshot.exists) {
      await _processUserData(snapshot.data() as Map<String, dynamic>);
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
      appBar: AppBar(
        title: const Text('My Courses'),
        actions: [
          // ✅ Optional: Manual refresh button
          IconButton(
            onPressed: _refreshCourses,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              // ✅ Pull to refresh
              onRefresh: _refreshCourses,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 60),
                child: Column(
                  children: [
                    // Search box
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
                    const SizedBox(height: 20),

                    // Dynamic button labels
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

                    // Display courses
                    currentIndex == 0
                        ? CoursesListBuilder(
                            courses: filteredCompleted,
                            isTeacher: isTeacher,
                          )
                        : CoursesListBuilder(
                            courses: filteredOngoing,
                            isTeacher: isTeacher,
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
