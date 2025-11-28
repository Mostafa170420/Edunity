import 'dart:developer';

import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {
  static Future<Map<String, dynamic>?> getUserData(
      UserTypeEnum userType) async {
    try {
      log('in repo');
      var userId = SharedPref.getUserId();

      log('after userid');

      final userData = userType == UserTypeEnum.teacher
          ? await FirebaseProvider.getTeacherByID(userId)
          : await FirebaseProvider.getStudentByID(userId);
      log(userData.toString());
      if (userData.exists) {
        return userData.data() as Map<String, dynamic>?;
      } else {
        log('User document does not exist for ID: $userId');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in getUserData: ${e.code} - ${e.message}');
      return null;
    } on FirebaseException catch (e) {
      log('FirebaseException in getUserData: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      log('Unknown error in getUserData: $e');
      return null;
    }
  }

  static Future<String?> uploadCourse({
    String? id,
    String? category,
    String? duration, // e.g., "1:36:10"
    String? instructor,
    String? language,
    String? level,
    String? name,
    int? numberOfVideos,
    double? rating,
    String? thumbnail,
  }) async {
    try {
      log('Uploading course: $name');

      // Create the course model
      final course = CourseModel(
        id: id,
        category: category,
        duration: duration,
        instructor: instructor,
        language: language,
        level: level,
        name: name,
        numberOfVideos: numberOfVideos,
        rating: rating,
        thumbnail: thumbnail,
      );

      // Upload to Firebase
      await FirebaseProvider.createCourse(course);
      log('Course uploaded successfully: ${course.name}');

      return "Course uploaded successfully";
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in uploadCourse: ${e.code} - ${e.message}');
      return "Authentication error: ${e.message}";
    } on FirebaseException catch (e) {
      log('FirebaseException in uploadCourse: ${e.code} - ${e.message}');
      return "Firebase error: ${e.message}";
    } catch (e, stackTrace) {
      log('Unknown error in uploadCourse: $e', stackTrace: stackTrace);
      return "Unknown error occurred";
    }
  }

  static Future<List<CourseModel>?> loadCourses() async {
    try {
      final snapshot = await FirebaseProvider.courseCollection.get();

      final courses = snapshot.docs
          .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>,
              id: doc.id))
          .toList();

      return courses; // success → return list
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in loadCourses: ${e.code} - ${e.message}');
      return null; // error → return null
    } on FirebaseException catch (e) {
      log('FirebaseException in loadCourses: ${e.code} - ${e.message}');
      return null; // error → return null
    } catch (e, stackTrace) {
      log('Unknown error in loadCourses: $e', stackTrace: stackTrace);
      return null; // error → return null
    }
  }
}
