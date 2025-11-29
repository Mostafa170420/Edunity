import 'dart:developer';

import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/auth/data/models/student_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepo {
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      log('in repo');
      var userId = SharedPref.getUserId();
      log('after userid');
      var userType = SharedPref.getUserType();
      log('after usertype');
      var userData;
      log('in repo');
      if (userType == 'Teacher') {
        userData = await FirebaseProvider.getTeacherByID(userId);
      } else if (userType == 'Student') {
        userData = await FirebaseProvider.getStudentByID(userId);
      } else {
        log('User type is not recognized: $userType');
        return null;
      }

      if (userData.exists) {
        return userData.data();
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

  static Future<String?> editProfile(
      String name, String bio, String dob, String image) async {
    try {
      log('wtf');
      log(SharedPref.getUserId());
      if (SharedPref.getUserType() == 'Teacher') {
        await FirebaseProvider.updateTeacher(TeacherModel(
            uid: SharedPref.getUserId(),
            name: name,
            bio: bio,
            dob: dob,
            avatarUrl: image));
        log(SharedPref.getUserId());
        return "updated";
      } else if (SharedPref.getUserType() == 'Student') {
        await FirebaseProvider.updateStudent(StudentModel(
            uid: SharedPref.getUserId(),
            name: name,
            bio: bio,
            dob: dob,
            avatarUrl: image));
        return "updated";
      }
      log('wtf2');
      return 'User type not found.';
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in editProfile: ${e.code} - ${e.message}');
      return null;
    } on FirebaseException catch (e) {
      log('FirebaseException in editProfile: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      log('Unknown error in editProfile: $e');
      return null;
    }
  }
}
