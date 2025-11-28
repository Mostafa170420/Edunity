import 'dart:developer';

import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/home/data/repo/home_repo.dart';
import 'package:edunity/feature/home/presentation/bloc/home_event.dart';
import 'package:edunity/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async {
      if (event is CourseUploadEvent) {
        await uploadCourse(event, emit);
      } else if (event is DataLoadEvent) {
        await loadHomeData(event, emit);
      }
    });
  }
  final formKey = GlobalKey<FormState>();

  final categoryController = TextEditingController();
  final durationController = TextEditingController();
  final instructorController = TextEditingController();
  final languageController = TextEditingController();
  final levelController = TextEditingController();
  final nameController = TextEditingController();
  final numVideosController = TextEditingController();
  final ratingController = TextEditingController();
  final thumbnailController = TextEditingController();

  Future<void> uploadCourse(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      // Parse number of videos and rating safely
      final numberOfVideos = int.tryParse(numVideosController.text) ?? 0;
      final rating = double.tryParse(ratingController.text) ?? 0.0;

      // Upload using HomeRepo
      final result = await HomeRepo.uploadCourse(
        id: courses[nameController.text],
        category: categoryController.text,
        duration: durationController.text,
        instructor: instructorController.text,
        language: languageController.text,
        level: levelController.text,
        name: nameController.text,
        numberOfVideos: numberOfVideos,
        rating: rating,
        thumbnail: thumbnailController.text,
      );

      if (result == null) {
        emit(HomeErrorState('Failed to upload course.'));
      } else {
        emit(HomeSuccessState());
      }
    } catch (e, stackTrace) {
      log('Error uploading course: $e', stackTrace: stackTrace);
      emit(HomeErrorState('An error occurred while uploading the course.'));
    }
  }

  Future<void> loadHomeData(
      DataLoadEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      var coursesDocs = await HomeRepo.loadCourses();
      var userData = await HomeRepo.getUserData(event.userType);

      if (coursesDocs == null) {
        emit(HomeErrorState('Failed to load course.'));
      } else if (userData == null) {
        emit(HomeErrorState('Failed to load user data.'));
      } else {
        emit(HomeSuccessState(courses: coursesDocs, userData: userData));
      }
    } catch (e, stackTrace) {
      log('Error uploading course: $e', stackTrace: stackTrace);
      emit(HomeErrorState('An error occurred while uploading the course.'));
    }
  }
}
