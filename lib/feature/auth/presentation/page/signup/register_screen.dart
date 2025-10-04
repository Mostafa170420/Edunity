import 'dart:developer';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:edunity/feature/auth/presentation/widgets/role_selection_toggle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

enum UserRole { student, tutor }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // --- Controllers (Equivalent to React formData) ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserRole _selectedRole = UserRole.student;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      log('Attempting Registration with Role: $_selectedRole');
      log('Name: ${_nameController.text}');
      log('Email: ${_emailController.text}');
      // In a real app, you would perform API calls here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    key: _formKey,
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
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter Your Name',
                            prefixIcon: Icon(IconlyLight.profile),
                          ),
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
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter Your Email',
                            prefixIcon: Icon(IconlyLight.message),
                          ),
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
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Password',
                            prefixIcon: Icon(IconlyLight.lock),
                          ),
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
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Re-enter Your Password',
                            prefixIcon: Icon(IconlyLight.lock),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
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
                            onPressed: _handleRegister,
                            label: 'Create Account', // <-- Fixed from 'Login'
                            icon: null,
                            iconAlignment: null,
                            borderRadius: 15,
                            padding: const EdgeInsets.symmetric(vertical: 15),
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

                        // Google Sign-up Button
                        ElevatedButton(
                            onPressed: () {
                              log('Continue with Google pressed');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                                side: BorderSide(
                                    color:
                                        AppColors.darkgreyColor.withAlpha(90)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BrandLogo(BrandLogos.google, size: 18),
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
    );
  }
}

