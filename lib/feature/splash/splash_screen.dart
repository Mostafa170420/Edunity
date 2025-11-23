// Import necessary packages and widgets for the splash screen.
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

/// The `SplashScreen` is a stateful widget that serves as the initial screen of the application.
/// It displays the app logo and a loading animation for a few seconds before navigating to the
/// welcome screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // After a delay of 3 seconds, the user is automatically navigated to the welcome screen.
    Future.delayed(const Duration(seconds: 3), () {
      pushWithReplacement(context, Routes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body is a container with a gradient background.
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              AppColors.primaryDarkColor,
              AppColors.primaryLightColor
            ])),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The app logo is displayed in a container with a background color and shadow.
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.logoBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greyColor.withAlpha(153), // Adjusted for clarity
                          blurRadius: 10,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      Icons.menu_book,
                      size: 50,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const Gap(25),
                // The app name and slogan are displayed below the logo.
                Text('Edunity',
                    style: TextStyles.getTitle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold)),
                const Gap(10),
                Text('Learn Together, Grow Together',
                    style: TextStyles.getSmall(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600)),
                const Gap(20),
                // A Lottie animation is used to display a loading indicator.
                SizedBox(
                  height: 150,
                  child: LottieBuilder.asset(
                    AppAssets.splashLoadingJson,
                    repeat: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
