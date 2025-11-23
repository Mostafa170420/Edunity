// Import necessary packages and widgets for the registration screen.
import 'dart:developer';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_event.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_state.dart';
import 'package:edunity/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:edunity/feature/auth/presentation/widgets/role_selection_toggle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

/// The `RegisterScreen` is a stateful widget that provides the UI for user registration.
/// It includes fields for name, email, password, and role selection.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

/// An enum to represent the user's role, which can be either a student or a teacher.
enum UserRole { student, teacher }

class _RegisterScreenState extends State<RegisterScreen> {
  UserRole _selectedRole = UserRole.student; // The default selected role is 'student'.

  /// This method is called when the user presses the register button.
  /// It validates the form and, if successful, dispatches a `RegisterEvent` to the `AuthBloc`.
  void _handleRegister(AuthBloc bloc) {
    if (bloc.formKey.currentState!.validate()) {
      final selectedUserType = _selectedRole == UserRole.student
          ? UserTypeEnum.student
          : UserTypeEnum.teacher;
      log('Registering as: $selectedUserType');
      bloc.add(RegisterEvent(userType: selectedUserType));
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AuthBloc>();

    // The `BlocListener` listens for state changes in the `AuthBloc` and handles them accordingly.
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthErrorState) {
            pop(context); // Close the loading dialog.
            log('Error: ${state.message}');
            showMyDialoge(context, state.message!); // Show an error dialog.
          } else if (state is AuthSuccessState) {
            pop(context); // Close the loading dialog.
            pushWithReplacement(context, Routes.main); // Navigate to the main screen.
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.all(16),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: bloc.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AuthHeaderWidget(),
                            const Gap(24),

                            // Full Name input field.
                            Text(
                              'Full Name',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.nameController,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter Your Name',
                              prefixIcon: const Icon(IconlyLight.profile),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Email input field.
                            Text(
                              'Email',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.emailController,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter Your Email',
                              prefixIcon: const Icon(IconlyLight.message),
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Password input field.
                            Text(
                              'Password',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.passwordController,
                              isPassword: true,
                              hintText: 'Enter Your Password',
                              prefixIcon: const Icon(IconlyLight.lock),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Confirm Password input field.
                            Text(
                              'Confirm Password',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.confirmPasswordController,
                              isPassword: true,
                              hintText: 'Re-enter Your Password',
                              prefixIcon: const Icon(IconlyLight.lock),
                              validator: (value) {
                                if (value != bloc.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const Gap(24),

                            // A toggle for selecting the user's role (student or teacher).
                            RoleSelectionToggle(
                              initialRole: _selectedRole,
                              onRoleChanged: (role) {
                                setState(() {
                                  _selectedRole = role;
                                });
                              },
                            ),
                            const Gap(16),

                            // A text widget with the terms of service and privacy policy.
                            Text(
                              'By signing up, you agree to our Terms of Service and Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: TextStyles.getSmall(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            const Gap(24),

                            // The main registration button.
                            SizedBox(
                              width: double.infinity,
                              child: GradientButton(
                                onPressed: () {
                                  _handleRegister(bloc);
                                },
                                label: 'Create Account',
                                borderRadius: 15,
                              ),
                            ),

                            const Gap(16),

                            // A divider with the text "Or Continue With".
                            const Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Or Continue With'),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const Gap(16),

                            // A button for signing up with Google. Note: The functionality is not implemented.
                            ElevatedButton(
                                onPressed: () {
                                  log('Continue with Google pressed');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    side: BorderSide(
                                        color: AppColors.darkgreyColor
                                            .withAlpha(90)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Brand(Brands.google, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Continue with Google',
                                      style: TextStyles.getSmall(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                            const Gap(20),
                            // A link to the login screen for users who already have an account.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    pushWithReplacement(context, Routes.login);
                                  },
                                  child: Text(
                                    "Already have an account? Login",
                                    style: TextStyles.getSmall(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryDarkColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
