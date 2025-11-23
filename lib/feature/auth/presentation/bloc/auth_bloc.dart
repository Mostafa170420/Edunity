// Import necessary packages for logging, BLoC, and Flutter material design.
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/auth/data/repo/auth_repo.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_event.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';

/// The [AuthBloc] class is responsible for managing the state of the authentication feature.
/// It handles user login and registration events, interacts with the [AuthRepo] to perform
/// authentication tasks, and emits the appropriate state changes.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// The constructor for the [AuthBloc]. It initializes the BLoC with an
  /// [AuthInitialState] and sets up event handlers for [LoginEvent] and [RegisterEvent].
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        await login(event, emit);
      } else if (event is RegisterEvent) {
        await register(event, emit);
      }
    });
  }

  // Text editing controllers for the registration and login forms.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Additional fields for teacher profiles.
  final bioController = TextEditingController();
  String? teachingSubjct;
  String imageUrl = '';

  // A global key for the form to manage form validation.
  final formKey = GlobalKey<FormState>();

  /// Handles the user registration process.
  ///
  /// This method is triggered when a [RegisterEvent] is dispatched. It emits an
  /// [AuthLoadingState], calls the [AuthRepo.register] method with the user's
  /// details, and then emits either an [AuthSuccessState] or an [AuthErrorState]
  /// based on the result of the registration attempt.
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    log('Starting registration for user type: ${event.userType}, Name: ${nameController.text}, Email: ${emailController.text}');

    var result = await AuthRepo.register(
      nameController.text,
      emailController.text,
      passwordController.text,
      confirmPasswordController.text,
      event.userType,
    );
    
    log('Registration result: $result');

    // Check the result from the repository and emit the corresponding state.
    if (result == 'Student') {
      emit(AuthSuccessState(UserTypeEnum.student));
    } else if (result == 'Teacher') {
      emit(AuthSuccessState(UserTypeEnum.teacher));
    } else {
      emit(AuthErrorState(result));
    }
  }

  /// Handles the user login process.
  ///
  /// This method is triggered when a [LoginEvent] is dispatched. It emits an
  /// [AuthLoadingState], calls the [AuthRepo.login] method, and then emits
  /// either an [AuthSuccessState] or an [AuthErrorState] based on the outcome.
  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    var result = await AuthRepo.login(
      emailController.text,
      passwordController.text,
      event.userType,
    );

    // NOTE: There seems to be a mismatch in the user type strings being checked.
    // The code checks for "Patient" and "Doctor" but emits states for "student" and "teacher".
    // This might be a bug or a leftover from a previous implementation.
    if (result == 'Student') { // Changed from 'Patient'
      emit(AuthSuccessState(UserTypeEnum.student));
    } else if (result == 'Teacher') { // Changed from 'Doctor'
      emit(AuthSuccessState(UserTypeEnum.teacher));
    } else {
      emit(AuthErrorState(result));
    }
  }
}
