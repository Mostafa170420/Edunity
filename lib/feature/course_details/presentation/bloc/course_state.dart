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

class CourseErrorState extends CourseState {
  final String message;

  CourseErrorState(this.message);
}
