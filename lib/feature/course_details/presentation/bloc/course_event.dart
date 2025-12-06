class CourseEvent {}

class AddToCartEvent extends CourseEvent {
  final String courseId;

  AddToCartEvent(this.courseId);
}

class LoadTeacherDataEvent extends CourseEvent {
  final String instructorId;

  LoadTeacherDataEvent(this.instructorId);
}
