import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';

class CourseService {
  // Get completed courses for a student
  static Future<List<CourseModel>> getCompletedCourses(String studentId) async {
    var studentSnapshot = await FirebaseProvider.getStudentByID(studentId);
    var data = studentSnapshot.data() as Map<String, dynamic>;
    List<String> completedIds =
        List<String>.from(data['completedCourses'] ?? []);

    if (completedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(completedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id))
        .toList();
  }

  // Get purchased (ongoing) courses for a student
  static Future<List<CourseModel>> getPurchasedCourses(String studentId) async {
    var studentSnapshot = await FirebaseProvider.getStudentByID(studentId);
    var data = studentSnapshot.data() as Map<String, dynamic>;
    List<String> purchasedIds =
        List<String>.from(data['purchasedCourses'] ?? []);

    if (purchasedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(purchasedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id))
        .toList();
  }

  // Get courses uploaded by a teacher
  static Future<List<CourseModel>> getTeacherCourses(String teacherId) async {
    var teacherSnapshot = await FirebaseProvider.getTeacherByID(teacherId);
    var data = teacherSnapshot.data() as Map<String, dynamic>;
    List<String> uploadedIds = List<String>.from(data['uploadedCourses'] ?? []);

    if (uploadedIds.isEmpty) return [];

    var coursesSnapshot = await FirebaseProvider.getCoursesByIds(uploadedIds);
    return coursesSnapshot.docs
        .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id))
        .toList();
  }
}
