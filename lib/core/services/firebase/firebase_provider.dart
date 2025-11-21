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
    teacherCollection.doc(teacher.uid).set(teacher.toMap());
  }

  static createStudent(StudentModel student) async {
    teacherCollection.doc(student.uid).set(student.toMap());
  }

  static updateTeacher(TeacherModel doctor) async {
    teacherCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static updateStudent(StudentModel student) async {
    studentCollection.doc(student.uid).update(student.toUpdateData());
  }

  static getTeacherByID(String id) {
    return teacherCollection.doc(id).get();
  }
}
