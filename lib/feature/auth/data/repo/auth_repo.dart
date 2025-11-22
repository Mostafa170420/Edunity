import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';

class AuthRepo {
  static Future<String?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
    UserTypeEnum userType,
  ) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;
      await user.updateDisplayName(name);
      SharedPref.setUserId(user.uid);

      if (userType == UserTypeEnum.teacher) {
        var teacher = TeacherModel(uid: user.uid, name: name, email: email);
        FirebaseProvider.createTeacher(teacher);
        return 'Teacher';
      } else {
        var student = StudentModel(uid: user.uid, name: name, email: email);
        FirebaseProvider.createStudent(student);
        return 'Student';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'Email is already in use.';
      } else {
        return 'Some error occurred. Please try again.';
      }
    } catch (e) {
      log(e.toString());
      return 'Some error occurred. Please try again.';
    }
  }

  static Future<String?> login(
    String email,
    String password,
    UserTypeEnum userType,
  ) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      SharedPref.setUserId(user.uid);

      return userType == UserTypeEnum.teacher ? 'Teacher' : 'Student';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        log(e.toString());
        return 'Some error occurred. Please try again.';
      }
    } catch (e) {
      log(e.toString());
      return 'Some error occurred. Please try again.';
    }
  }

  static Future<String?> updateTeacherData(TeacherModel teacher) async {
    try {
      FirebaseProvider.updateTeacher(teacher);
      return null;
    } catch (e) {
      log(e.toString());
      return 'Some error occurred. Please try again.';
    }
  }

  static Future<String?> updateStudentData(StudentModel student) async {
    try {
      FirebaseProvider.updateStudent(student);
      return null;
    } catch (e) {
      log(e.toString());
      return 'Some error occurred. Please try again.';
    }
  }
}
