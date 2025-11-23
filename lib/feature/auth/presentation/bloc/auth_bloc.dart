import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/auth/data/repo/auth_repo.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_event.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        await login(event, emit);
      } else if (event is RegisterEvent) {
        await register(event, emit);
      }
    });
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final bioController = TextEditingController();
  String? teachingSubjct;
  String imageUrl = '';

  final formKey = GlobalKey<FormState>();

  register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    log('Starting registration for user type: ${event.userType}, Name: ${nameController.text}, Email: ${emailController.text}, Password: ${passwordController.text}, Confirm Password: ${confirmPasswordController.text}');

    var result = await AuthRepo.register(
      nameController.text,
      emailController.text,
      passwordController.text,
      confirmPasswordController.text,
      event.userType,
    );
    log('Registration result: $result');
    if (result == 'Student') {
      emit(AuthSuccessState(UserTypeEnum.student));
    } else if (result == 'Teacher') {
      emit(AuthSuccessState(UserTypeEnum.teacher));
    } else {
      emit(AuthErrorState(result));
    }
  }

  login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    var result = await AuthRepo.login(
      emailController.text,
      passwordController.text,
      event.userType,
    );
    if (result == 'Patient') {
      emit(AuthSuccessState(UserTypeEnum.student));
    } else if (result == 'Doctor') {
      emit(AuthSuccessState(UserTypeEnum.teacher));
    } else {
      emit(AuthErrorState(result));
    }
  }
}
