import 'dart:developer';

import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/feature/bookmark/model/courses_names_model.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {
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
}
