import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';

class BookmarkService {
  static Future<void> bookmarkCourses({required String courseId}) async {
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
    log('Toggling bookmark for course ID: $courseId');
    if (bookmarkedIds.contains(courseId)) {
      log('Removing bookmark for course ID: $courseId');
      bookmarkedIds.removeWhere((courseID) => courseID == courseId);
      log('After removal, bookmarked IDs: $bookmarkedIds');
    } else {
      log('Adding bookmark for course ID: $courseId');
      bookmarkedIds.add(courseId);
      log('After addition, bookmarked IDs: $bookmarkedIds');
    }

    log('After operation, bookmarked IDs: $bookmarkedIds');
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

  static Future<bool> isBookmarked({required String courseId}) async {
    final userId = SharedPref.getUserId();
    late DocumentSnapshot snapshot;

    if (SharedPref.getUserType() == 'Student') {
      snapshot = await FirebaseProvider.getStudentByID(userId);
    } else {
      snapshot = await FirebaseProvider.getTeacherByID(userId);
    }

    List<String> bookmarkedIds =
        List<String>.from(snapshot['bookmarkedCourses']);
    if (bookmarkedIds.contains(courseId)) {
      return true;
    }
    return false;
  }
}
