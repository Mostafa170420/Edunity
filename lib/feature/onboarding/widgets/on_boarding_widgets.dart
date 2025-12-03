import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnBoardingWidgets extends StatelessWidget {
  const OnBoardingWidgets({
    super.key,
    required this.onboardingPage,
  });

  final OnboardingModel onboardingPage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryDarkColor,
                  AppColors.primaryLightColor
                ]),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: onboardingPage.icon,
          ),
        ),
        SizedBox(height: 25),
        Text(
          onboardingPage.title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            onboardingPage.description ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
