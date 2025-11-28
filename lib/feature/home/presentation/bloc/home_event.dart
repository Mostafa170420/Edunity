import 'package:edunity/feature/auth/data/models/user_type_enum.dart';

class HomeEvent {}

class CourseUploadEvent extends HomeEvent {}

class CourseLoadEvent extends HomeEvent {}

class DataLoadEvent extends HomeEvent {
  final UserTypeEnum userType;

  DataLoadEvent({required this.userType});
}
