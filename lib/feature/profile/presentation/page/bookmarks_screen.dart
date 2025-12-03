import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/search/widgets/courses_grid_builder.dart';
import 'package:flutter/material.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Courses')),
      body: FutureBuilder<List<CourseModel>>(
        future: getBookmarkedCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookmarked courses'));
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: CoursesGridBuilder(courses: snapshot.data!),
          );
        },
      ),
    );
  }
}

Future<List<CourseModel>> getBookmarkedCourses() async {
  final userId = SharedPref.getUserId();
  final userType = SharedPref.getUserType();

  List<String> bookmarkedIds = [];

  // Fetch user document
  final snapshot = userType == 'Student'
      ? await FirebaseProvider.getStudentByID(userId)
      : await FirebaseProvider.getTeacherByID(userId);

  bookmarkedIds = List<String>.from(snapshot['bookmarkedCourses'] ?? []);

  // No bookmarks
  if (bookmarkedIds.isEmpty) return [];

  // Query all bookmarked courses at once (much faster)
  final coursesSnapshot = await FirebaseProvider.getCoursesByIds(bookmarkedIds);

  return coursesSnapshot.docs
      .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
}
