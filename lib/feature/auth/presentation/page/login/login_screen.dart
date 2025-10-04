import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.all(16),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthHeaderWidget(),
                  Gap(16),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // labelText: 'ُEmail',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter Your Email',
                      prefixIcon: Icon(IconlyLight.message),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(IconlyLight.lock),
                    ),
                    obscureText: true,
                  ),
                  Gap(16),
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      onPressed: () {
                        // Handle login logic
                      },
                      label: 'Login',
                      icon: null,
                      iconAlignment: null,
                      borderRadius: 15,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  Gap(16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or Continue With'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  Gap(16),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                          side: BorderSide(
                              color: AppColors.darkgreyColor.withAlpha(90)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BrandLogo(BrandLogos.google, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Continue with Google',
                            style: TextStyles.getSmall(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                  SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to the registration screen
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
        ],
      ),
    );
  }
}
