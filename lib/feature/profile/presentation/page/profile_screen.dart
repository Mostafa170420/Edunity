import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> profileOptions = [
      {
        'title': 'Profile',
        'icon': AppAssets.profileSvg,
        'route': Routes.editProfile
      },
      {
        'title': 'Dark Mode',
        'icon': AppAssets.darkModeSvg,
        // 'route': Routes.darkMode
      },
      {
        'title': 'Notifications',
        'icon': AppAssets.notificationSvg,
        // 'route': Routes.notifications
      },
      {
        'title': 'Language',
        'icon': AppAssets.languageSvg,
        // 'route': Routes.language
      },
      {
        'title': 'Payment',
        'icon': AppAssets.paymentSvg,
        // 'route': Routes.payment
      },
      {
        'title': 'Security',
        'icon': AppAssets.securitySvg,
        // 'route': Routes.security
      },
      {
        'title': 'Help Center',
        'icon': AppAssets.helpCenterSvg,
        // 'route': Routes.helpCenter
      },
      {
        'title': 'Terms & Conditions',
        'icon': AppAssets.termsSvg,
        // 'route': Routes.terms
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyles.getTitle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ProfileCard(
              isCameraEnabled: false,
            ),
            Gap(30),
            ListView.separated(
              itemCount: profileOptions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final option = profileOptions[index];
                return profileOption(
                  option['icon']!,
                  option['title']!,
                  () => pushTo(context, option['route']!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget profileOption(String svgPath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: SvgPicture.asset(
                svgPath,
                fit: BoxFit.contain,
                color: AppColors.logoBackgroundColor,
              ),
            ),
            Gap(16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
