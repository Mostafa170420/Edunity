import 'dart:developer';

import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/feature/profile/data/repo/profile_repo.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_event.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is editProfileEvent) {
      } else if (event is ProfileLoadEvent) {
        await initializeFields(event, emit);
      } else if (event is UpdateProfileEvent) {
        await updateProfile(event, emit);
      }
    });
  }
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();

  final bioController = TextEditingController();

  String? imageUrl;

  final formKey = GlobalKey<FormState>();

  Future<void> initializeFields(
      ProfileLoadEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      var userData = await ProfileRepo.getUserData();

      if (userData == null) {
        emit(ProfileErrorState('Failed to load user data.'));
        return;
      }

      fullNameController.text = userData['name'] ?? '';
      dobController.text = userData['dob'] ?? '';
      bioController.text = userData['bio'] ?? '';
      imageUrl = userData['avatarUrl'] ?? '';
      ;

      emit(ProfileSuccessState());
    } catch (e) {
      // Send caught exception message to UI
      emit(ProfileErrorState('An error occurred: $e'));
    }
  }

  updateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      var result = await ProfileRepo.editProfile(fullNameController.text,
          bioController.text, dobController.text, imageUrl ?? '');

      if (result == null) {
        emit(ProfileErrorState('Failed to update user data.'));
        return;
      }

      emit(ProfileSuccessState(message: 'Updated user data.'));
    } catch (e) {
      emit(ProfileErrorState('An error occurred: $e'));
    }
  }
}
