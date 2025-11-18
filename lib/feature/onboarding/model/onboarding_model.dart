import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class OnboardingModel {
  final String? imageIcon;
  final Icon? icon;
  final String title;
  final String? description;

  OnboardingModel({
    this.icon,
    this.imageIcon,
    required this.title,
    this.description,
  });
}

List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    icon: Icon(IconlyLight.search, size: 80, color: Colors.white),
    imageIcon: 'assets/images/onboarding1.png',
    title: 'Discover the right tutor for you',
    description:
        'Browse through hundreds of qualified tutors and find the perfect match for your learning goals.',
  ),
  OnboardingModel(
    icon: Icon(IconlyLight.calendar, size: 80, color:Colors.white),
    imageIcon: 'assets/images/onboarding2.png',
    title: 'Book sessions with ease',
    description:
        'Schedule one-on-one sessions or group classes that fit your schedule perfectly.',
  ),
  OnboardingModel(
    icon: Icon(IconlyLight.play, size: 80, color:Colors.white),
    imageIcon: 'assets/images/onboarding3.png',
    title: 'Learn anytime, anywhere',
    description:
        'Access your courses and attend live sessions from any device, anywhere in the world.',
  ),
];
