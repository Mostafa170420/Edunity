import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';

class BookmarkService {
  static Future<void> bookmarkCourses(
      {required bool isBookmarked, required String courseId}) async {
    final userId = SharedPref.getUserId();
    late DocumentSnapshot snapshot;

    if (SharedPref.getUserType() == 'Student') {
      snapshot = await FirebaseProvider.getStudentByID(userId);
    } else {
      snapshot = await FirebaseProvider.getTeacherByID(userId);
    }

    List<String> bookmarkedIds =
        List<String>.from(snapshot['bookmarkedCourses']);
    log('Current bookmarked IDs: $bookmarkedIds');
    if (isBookmarked) {
      log('Adding bookmark for course ID: $courseId');
      log('Before adding, bookmarked IDs: $bookmarkedIds');
      if (!bookmarkedIds.contains(courseId)) {
        bookmarkedIds.add(courseId);
      }
    } else {
      log('Removing bookmark for course ID: $courseId');
      bookmarkedIds.removeWhere((courseID) => courseID == courseId);
    }

    if (SharedPref.getUserType() == 'Student') {
      await FirebaseProvider.updateStudent(StudentModel(
        uid: userId,
        bookmarkedCourses: bookmarkedIds,
      ));
    } else {
      await FirebaseProvider.updateTeacher(TeacherModel(
        uid: userId,
        bookmarkedCourses: bookmarkedIds,
      ));
    }
  }
}
