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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum UserRole { student, teacher }

class _RegisterScreenState extends State<RegisterScreen> {
  UserRole _selectedRole = UserRole.student; // Default

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
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthErrorState) {
            pop(context);
            log('Error: ${state.message}');
            showMyDialoge(context, state.message!);
          } else if (state is AuthSuccessState) {
            pop(context);
            pushWithReplacement(context, Routes.main, extra: state.userType);
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

                            // Full Name Field
                            Text(
                              'Full Name',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.nameController,
                              keyboardType: TextInputType.name,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Enter Your Name',
                              prefixIcon: Icon(IconlyLight.profile),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Email Field
                            Text(
                              'Email',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.emailController,
                              keyboardType: TextInputType.emailAddress,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(IconlyLight.message),
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Password Field
                            Text(
                              'Password',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.passwordController,
                              isPassword: true,
                              hintText: 'Enter Your Password',
                              prefixIcon: Icon(IconlyLight.lock),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),

                            // Confirm Password Field
                            Text(
                              'Confirm Password',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            CustomTextField(
                              controller: bloc.confirmPasswordController,
                              isPassword: true,
                              hintText: 'Re-enter Your Password',
                              prefixIcon: Icon(IconlyLight.lock),
                              validator: (value) {
                                if (value != bloc.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const Gap(24),

                            // Role Selection Toggle (Fixed component)
                            RoleSelectionToggle(
                              initialRole: _selectedRole,
                              onRoleChanged: (role) {
                                setState(() {
                                  _selectedRole = role;
                                });
                              },
                            ),
                            const Gap(16),

                            // Terms and Policy Text
                            Text(
                              'By signing up, you agree to our Terms of Service and Privacy Policy.',
                              style: TextStyles.getSmall(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            const Gap(24),

                            // Register Button (Fixed label)
                            SizedBox(
                              width: double.infinity,
                              child: GradientButton(
                                onPressed: () {
                                  _handleRegister(bloc);
                                },
                                label:
                                    'Create Account', // <-- Fixed from 'Login'
                                icon: null,
                                iconAlignment: null,
                                borderRadius: 15,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),

                            const Gap(16),

                            // Divider
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

                            // Google Sign-up Button
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
                            // Login Link (Fixed text)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    pushWithReplacement(context, Routes.login);
                                  },
                                  child: Text(
                                    "Already have an account? Login", // <-- Fixed
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
