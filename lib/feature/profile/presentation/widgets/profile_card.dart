import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.onCameraTap});

  // final bool isCameraEnabled;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //     color: AppColors.logoBackgroundColor, width: 5),
                  shape: BoxShape.circle,
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryLightColor,
                      AppColors.primaryDarkColor,
                    ],
                    transform: const GradientRotation(90 * 3.14 / 180),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=3'),
                ),
              ),
              Gap(16),
              const Text(
                'profile name',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Gap(8),
              const Text(
                'gmail@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          Positioned(
              bottom: 78,
              right: 12,
              child: GradientButton(
                label: '',
                onPressed: onCameraTap,
                width: 40,
                icon: SvgPicture.asset(
                  AppAssets.cameraSvg,
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                iconAlignment: IconAlignment.start,
              )),
        ],
      ),
    );
  }
}
