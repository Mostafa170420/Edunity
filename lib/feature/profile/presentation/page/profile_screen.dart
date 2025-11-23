// Import necessary packages and widgets for the profile screen.
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

/// The `ProfileScreen` is a stateless widget that displays the user's profile information
/// and provides a list of options for managing their account and app settings.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A list of options to be displayed on the profile screen.
    // Each option is a map containing a title, icon path, and a route to navigate to.
    // Note: Some routes are commented out, indicating that the features are not yet implemented.
    final List<Map<String, String>> profileOptions = [
      {
        'title': 'Edit Profile',
        'icon': AppAssets.profileSvg,
        'route': Routes.editProfile
      },
      {
        'title': 'Bookmarks',
        'icon': AppAssets.bookmarkOutline,
        'route': Routes.bookmark
      },
      {
        'title': 'Dark Mode',
        'icon': AppAssets.darkModeSvg,
        // 'route': Routes.darkMode // Not implemented
      },
      {
        'title': 'Notifications',
        'icon': AppAssets.notificationSvg,
        // 'route': Routes.notifications // Not implemented
      },
      {
        'title': 'Language',
        'icon': AppAssets.languageSvg,
        // 'route': Routes.language // Not implemented
      },
      {
        'title': 'Payment',
        'icon': AppAssets.paymentSvg,
        // 'route': Routes.payment // Not implemented
      },
      {
        'title': 'Security',
        'icon': AppAssets.securitySvg,
        // 'route': Routes.security // Not implemented
      },
      {
        'title': 'Help Center',
        'icon': AppAssets.helpCenterSvg,
        // 'route': Routes.helpCenter // Not implemented
      },
      {
        'title': 'Terms & Conditions',
        'icon': AppAssets.termsSvg,
        // 'route': Routes.terms // Not implemented
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
            // The `ProfileCard` widget displays the user's basic information, such as
            // their name, profile picture, and email.
            ProfileCard(
              onCameraTap: () {
                // This function is called when the camera icon on the profile picture is tapped.
                // TODO: Implement image picking functionality.
              },
            ),
            const Gap(30),
            
            // A `ListView` to display the list of profile options.
            ListView.separated(
              itemCount: profileOptions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // The list should not be scrollable on its own.
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final option = profileOptions[index];
                // Build each option using the `profileOption` helper widget.
                // The `route` can be null for unimplemented features.
                return profileOption(
                  option['icon']!,
                  option['title']!,
                  () {
                    if (option['route'] != null) {
                      pushTo(context, option['route']!);
                    }
                  },
                );
              },
            ),
            const Gap(100), // Provides extra space at the bottom.
          ],
        ),
      ),
    );
  }

  /// A helper widget to build a single profile option item.
  ///
  /// This widget creates a tappable container with an icon, a title, and a forward arrow.
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
            const Gap(16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
