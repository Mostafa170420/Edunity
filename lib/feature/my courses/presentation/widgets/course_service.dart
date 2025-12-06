import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';

class CourseService {
  // ==================== STUDENT METHODS ====================

  /// Get completed courses for a student
  static Future<List<CourseModel>> getStudentCompletedCourses(
      String studentId) async {
    var studentSnapshot = await FirebaseProvider.getStudentByID(studentId);
    var data = studentSnapshot.data() as Map<String, dynamic>;
    List<String> completedIds =
        List<String>.from(data['completedCourses'] ?? []);

    if (completedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(completedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }

  /// Get purchased (ongoing) courses for a student
  static Future<List<CourseModel>> getStudentOngoingCourses(
      String studentId) async {
    var studentSnapshot = await FirebaseProvider.getStudentByID(studentId);
    var data = studentSnapshot.data() as Map<String, dynamic>;
    List<String> purchasedIds =
        List<String>.from(data['purchasedCourses'] ?? []);

    if (purchasedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(purchasedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }

  // ==================== TEACHER METHODS ====================

  /// Get live sessions (ongoing) for a teacher
  static Future<List<CourseModel>> getTeacherLiveSessions(
      String teacherId) async {
    var teacherSnapshot = await FirebaseProvider.getTeacherByID(teacherId);
    var data = teacherSnapshot.data() as Map<String, dynamic>;
    List<String> liveSessionIds = List<String>.from(data['liveSessions'] ?? []);

    if (liveSessionIds.isEmpty) return [];

    var coursesSnapshot =
        await FirebaseProvider.getCoursesByIds(liveSessionIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }

  /// Get uploaded courses (completed) for a teacher
  static Future<List<CourseModel>> getTeacherUploadedCourses(
      String teacherId) async {
    var teacherSnapshot = await FirebaseProvider.getTeacherByID(teacherId);
    var data = teacherSnapshot.data() as Map<String, dynamic>;
    List<String> uploadedIds = List<String>.from(data['uploadedCourses'] ?? []);

    if (uploadedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(uploadedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }
}
