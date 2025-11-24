import 'dart:developer';

import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // bool isOnBoardingShown = SharedPref.getIsOnBoardingShown() ?? false;
    String? userType = FirebaseAuth.instance.currentUser?.photoURL;
    log('userType in splash: $userType');
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (userType == '1') {
        pushToBase(context, Routes.main, extra: UserTypeEnum.student);
      } else if (userType == '2') {
        pushToBase(context, Routes.main, extra: UserTypeEnum.teacher);
      } else {
        pushWithReplacement(context, Routes.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.logoBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greyColor.withValues(alpha: 0.6),
                          blurRadius: 10,
                          offset: Offset(0, 2)),
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
                Gap(25),
                Text('Edunity',
                    style: TextStyles.getTitle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold)),
                Gap(10),
                Text('Learn Together, Grow Together',
                    style: TextStyles.getSmall(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600)),
                Gap(20),
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
