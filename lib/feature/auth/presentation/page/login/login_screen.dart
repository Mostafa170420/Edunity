import 'dart:developer';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_event.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_state.dart';
import 'package:edunity/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _handleLogin(AuthBloc bloc) {
    if (bloc.formKey.currentState!.validate()) {
      bloc.add(LoginEvent());
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
          showMyDialoge(context, state.message ?? 'An error occurred');
        } else if (state is AuthSuccessState) {
          pop(context);

          if (state.userType == UserTypeEnum.student) {
            log('Logged in as Student');
            pushToBase(context, Routes.main, extra: UserTypeEnum.student);
            // showMyDialoge(context,
            //     'Welcome Student ${FirebaseProvider.getStudentByID(SharedPref.getUserId()).get('name')}');
            log('Logged in as Student');
          } else {
            pushToBase(context, Routes.main, extra: UserTypeEnum.teacher);
            log('Logged in as Teacher');
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.all(16),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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

                      // Email Field
                      Text(
                        'Email',
                        style: TextStyles.getSmall(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      CustomTextField(
                        controller: bloc.emailController,
                        keyboardType: TextInputType.emailAddress,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      const Gap(24),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: GradientButton(
                          onPressed: () => _handleLogin(bloc),
                          label: 'Login',
                          borderRadius: 15,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          icon: null,
                          iconAlignment: null,
                        ),
                      ),
                      const Gap(16),

                      // Divider
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Or Continue With'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const Gap(16),

                      // Google Sign-in
                      ElevatedButton(
                        onPressed: () {
                          log('Continue with Google pressed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          side: BorderSide(
                              color: AppColors.darkgreyColor.withAlpha(90)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Brand(Brands.google, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Continue with Google',
                              style: TextStyles.getSmall(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),

                      // Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              pushWithReplacement(context, Routes.register);
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
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
          ),
        ),
      ),
    );
  }
}
