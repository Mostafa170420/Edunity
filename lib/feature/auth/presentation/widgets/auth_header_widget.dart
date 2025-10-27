import 'package:edunity/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: Colors.blueAccent,
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryDarkColor,
                  AppColors.primaryLightColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                IconlyLight.profile,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Sign in to continue your learning journey',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
