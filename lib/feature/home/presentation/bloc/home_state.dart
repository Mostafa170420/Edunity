import 'package:edunity/feature/home/data/model/course_model.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final String? message;
  Map<String, dynamic>? userData;
  final List<CourseModel>? courses;

  HomeSuccessState({this.courses, this.message, this.userData});
}

class HomeErrorState extends HomeState {
  final String? message;

  HomeErrorState(this.message);
}

// class CourseLoadErrorState extends HomeState {
//   final String? message;

//   CourseLoadErrorState(this.message);
// }
