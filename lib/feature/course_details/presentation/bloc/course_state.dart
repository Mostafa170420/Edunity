import 'package:edunity/feature/auth/data/models/teacher_model.dart';

class CourseState {}

class CourseInitialState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CourseSuccessState extends CourseState {
  final String? message;
  CourseSuccessState({this.message});
}

class AddToCartSuccessState extends CourseState {
  final String? message;
  AddToCartSuccessState({this.message});
}

class TeacherLoadDataSuccessState extends CourseState {
  final TeacherModel teacher;

  TeacherLoadDataSuccessState({required this.teacher});
}

class TeacherLoadDataErrorState extends CourseState {
  final String message;

  TeacherLoadDataErrorState(this.message);
}

class CourseErrorState extends CourseState {
  final String message;

  CourseErrorState(this.message);
}
