import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';

class CourseRepo {
  static Future<String?> addToCart(String courseId) async {
    try {
      var userId = SharedPref.getUserId();
      var userType = SharedPref.getUserType();
      final snapshot = userType == 'Student'
          ? await FirebaseProvider.getStudentByID(userId)
          : await FirebaseProvider.getTeacherByID(userId);

      List<String> purchasedCourses =
          List<String>.from(snapshot['purchasedCourses']);
      log('Current purchased courses before adding: $purchasedCourses');
      if (purchasedCourses.contains(courseId)) {
        return 'Course already purchased';
      }
      purchasedCourses.add(courseId);

      if (userType == 'Student') {
        await FirebaseProvider.updateStudent(StudentModel(
          uid: userId,
          purchasedCourses: purchasedCourses,
        ));
      } else {
        await FirebaseProvider.updateTeacher(TeacherModel(
          uid: userId,
          purchasedCourses: purchasedCourses,
        ));
      }
      log('Current purchased courses: $purchasedCourses');
      return null;
    } on FirebaseException catch (e) {
      log("Firebase Error: ${e.message}");
      return "Firebase error: ${e.message}";
    } catch (e, st) {
      log("Unknown Error: $e\n$st");
      return "Unexpected error occurred.";
    }
  }
}
