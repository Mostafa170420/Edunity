// Import necessary packages for logging, Firebase Authentication, and other project services.
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';

/// The `AuthRepo` class handles all authentication-related data operations.
/// It communicates with Firebase Authentication and the Firebase Firestore database
/// through the `FirebaseProvider`.
class AuthRepo {
  /// Registers a new user with email, password, and user type.
  ///
  /// This method creates a new user account using Firebase Authentication.
  /// If successful, it also creates a corresponding student or teacher document
  /// in the Firestore database.
  ///
  /// Returns a string indicating the result of the operation ('Teacher', 'Student', or an error message).
  static Future<String?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
    UserTypeEnum userType,
  ) async {
    try {
      // Create the user with email and password.
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      // Update the user's display name.
      await user.updateDisplayName(name);

      // Store the user ID locally.
      SharedPref.setUserId(user.uid);

      // Create a user record in Firestore based on the user type.
      if (userType == UserTypeEnum.teacher) {
        user.updatePhotoURL('2');
        var teacher = TeacherModel(uid: user.uid, name: name, email: email);
        FirebaseProvider.createTeacher(teacher);
        return 'Teacher';
      } else {
        user.updatePhotoURL('1');
        var student = StudentModel(uid: user.uid, name: name, email: email);
        FirebaseProvider.createStudent(student);
        return 'Student';
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Authentication exceptions.
      if (e.code == 'weak-password') {
        return 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'Email is already in use.';
      } else {
        return 'An error occurred. Please try again.';
      }
    } catch (e) {
      // Log and handle any other exceptions.
      log(e.toString());
      return 'An error occurred. Please try again.';
    }
  }

  /// Logs in a user with their email and password.
  ///
  /// This method signs in an existing user with Firebase Authentication.
  /// If successful, it stores the user's ID in shared preferences.
  ///
  /// Returns a string indicating the user type ('Teacher' or 'Student') on success,
  /// or an error message on failure.
  static Future<String?> login(
    String email,
    String password,
  ) async {
    try {
      // Sign in the user with email and password.
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;

      // Store the user ID locally.
      SharedPref.setUserId(user.uid);

      var studentDoc = await FirebaseProvider.getStudentByID(user.uid);
      if (studentDoc.exists) {
        user.updatePhotoURL('1');
        return 'Student';
      }

      var teacherDoc = await FirebaseProvider.getTeacherByID(user.uid);
      if (teacherDoc.exists) {
        user.updatePhotoURL('2');
        return 'Teacher';
      }
      return 'User type not found.';
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Authentication exceptions.
      if (e.code == 'user-not-found') {
        return 'User not found.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        log(e.toString());
        return 'An error occurred. Please try again.';
      }
    } catch (e) {
      // Log and handle any other exceptions.
      log(e.toString());
      return 'An error occurred. Please try again.';
    }
  }

  /// Updates a teacher's data in the database.
  ///
  /// This method calls the `FirebaseProvider` to update the teacher's information.
  ///
  /// Returns `null` on success, or an error message on failure.
  static Future<String?> updateTeacherData(TeacherModel teacher) async {
    try {
      FirebaseProvider.updateTeacher(teacher);
      return null;
    } catch (e) {
      log(e.toString());
      return 'An error occurred. Please try again.';
    }
  }

  /// Updates a student's data in the database.
  ///
  /// This method calls the `FirebaseProvider` to update the student's information.
  ///
  /// Returns `null` on success, or an error message on failure.
  static Future<String?> updateStudentData(StudentModel student) async {
    try {
      FirebaseProvider.updateStudent(student);
      return null;
    } catch (e) {
      log(e.toString());
      return 'An error occurred. Please try again.';
    }
  }
}
