import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';

class FirebaseProvider {
  static final FirebaseFirestore firebase = FirebaseFirestore.instance;

  static final CollectionReference teacherCollection = firebase.collection(
    'Teacher',
  );
  static final CollectionReference studentCollection = firebase.collection(
    'Student',
  );

  static final CollectionReference courseCollection = firebase.collection(
    'Courses',
  );

  static createTeacher(TeacherModel teacher) async {
    teacherCollection.doc(teacher.uid).set(teacher.toJson());
  }

  static createStudent(StudentModel student) async {
    studentCollection.doc(student.uid).set(student.toJson());
  }

  static createCourse(CourseModel courses) async {
    courseCollection.doc(courses.id).set(courses.toJson());
  }

  static Future<QuerySnapshot> getCoursesByName(String searchKey) async {
    return await courseCollection
        .orderBy('nameLowercase')
        .startAt([searchKey]).endAt(['$searchKey\uf8ff']).get();
  }

  static Future<QuerySnapshot> getCoursesByCategory(String category) async {
    return await courseCollection
        .orderBy('category')
        .where('category', isEqualTo: category)
        .get();
  }

  static Future<QuerySnapshot> getCoursesByIds(List<String> ids) {
    return courseCollection.where(FieldPath.documentId, whereIn: ids).get();
  }

  static updateTeacher(TeacherModel teacher) async {
    await teacherCollection.doc(teacher.uid).update(teacher.toUpdateData());
  }

  static updateStudent(StudentModel student) async {
    await studentCollection.doc(student.uid).update(student.toUpdateData());
  }

  static Future<DocumentSnapshot<Object?>> getTeacherByID(String id) {
    return teacherCollection.doc(id).get();
  }

  static Future<DocumentSnapshot<Object?>> getStudentByID(String id) {
    return studentCollection.doc(id).get();
  }

  static Future<QuerySnapshot> getAllCourses() {
    return courseCollection.get();
  }

  static Future<QuerySnapshot> sortTeacherByRating() async {
    return await teacherCollection.orderBy('rating', descending: true).get();
  }

  static Stream<DocumentSnapshot> getStudentStreamByID(String id) {
    return FirebaseFirestore.instance
        .collection('students')
        .doc(id)
        .snapshots();
  }
}
