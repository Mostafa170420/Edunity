class CourseEvent {}

class AddToCartEvent extends CourseEvent {
  final String courseId;

  AddToCartEvent(this.courseId);
}
