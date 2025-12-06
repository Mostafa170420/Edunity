import 'package:edunity/feature/course_details/data/repo/course_repo.dart';
import 'package:edunity/feature/course_details/presentation/bloc/course_event.dart';
import 'package:edunity/feature/course_details/presentation/bloc/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitialState()) {
    on<CourseEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        await addToCart(event, emit);
      } else if (event is LoadTeacherDataEvent) {
        await loadTeacherData(event, emit);
      }
    });
  }
  Future<void> addToCart(
      AddToCartEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());
    try {
      final errorMessage = await CourseRepo.addToCart(event.courseId);
      if (errorMessage != null) {
        emit(CourseErrorState(errorMessage));
        return;
      }
      emit(AddToCartSuccessState(message: 'Course added to cart successfully'));
    } catch (e) {
      emit(CourseErrorState(e.toString()));
    }
  }

  Future<void> loadTeacherData(
      LoadTeacherDataEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());
    try {
      var teacherData = await CourseRepo.loadTeacherData(event.instructorId);
      emit(TeacherLoadDataSuccessState(teacher: teacherData));
    } catch (e) {
      emit(TeacherLoadDataErrorState(e.toString()));
    }
  }
}
