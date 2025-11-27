import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';

class FirebaseProvider {
  static final FirebaseFirestore firebase = FirebaseFirestore.instance;

  static final CollectionReference teacherCollection = firebase.collection(
    'Teacher',
  );
  static final CollectionReference studentCollection = firebase.collection(
    'Student',
  );

  static createTeacher(TeacherModel teacher) async {
    teacherCollection.doc(teacher.uid).set(teacher.toJson());
  }

  static createStudent(StudentModel student) async {
    studentCollection.doc(student.uid).set(student.toJson());
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
}
