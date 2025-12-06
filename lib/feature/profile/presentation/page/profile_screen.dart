import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/data/model/profile_tabs_model.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_event.dart';
import 'package:edunity/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

/// The `ProfileScreen` is a stateless widget that displays the user's profile information
/// and provides a list of options for managing their account and app settings.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool isDarkMode;
  @override
  void initState() {
    super.initState();
    isDarkMode = SharedPref.getDarkMode() ?? false;
    context.read<ProfileBloc>().add(ProfileLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileBloc>();
    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).padding.bottom + 100,
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: (SharedPref.getUserImage() ?? '')
                                .isNotEmpty
                            ? NetworkImage(SharedPref.getUserImage() ?? '')
                                as ImageProvider
                            : NetworkImage(bloc.imageUrl ??
                                "https://res.cloudinary.com/dltddu8ah/image/upload/v1764722376/defaultUser_d0jch4.png"),
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              ],
            ),
            const Gap(30),

            // A `ListView` to display the list of profile options.
            ListView.separated(
              itemCount: profileOptions.length,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // The list should not be scrollable on its own.
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final option = profileOptions[index];
                return profileOption(
                  title: option.title,
                  svgPath: option.icon,
                  onTap: () {
                    if (option.title == 'Dark Mode') {
                      setState(() {
                        isDarkMode = !isDarkMode;
                      });
                      return;
                    }
                    if (option.route != null) {
                      pushTo(context, option.route ?? '');
                    }
                  },
                );
              },
            ),
            Gap(40),
            GradientButton(
                label: 'Logout',
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                onPressed: () {
                  showSignOutDialog(context);
                })
          ],
        ),
      ),
    );
  }

  Widget profileOption(
      {String? title, String? svgPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
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
                svgPath ?? '',
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    AppColors.logoBackgroundColor, BlendMode.srcIn),
              ),
            ),
            Gap(16),
            Text(
              title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            title == 'Dark Mode'
                ? Switch(
                    value: isDarkMode,
                    onChanged: (val) {
                      setState(() {
                        isDarkMode = val;
                        SharedPref.setDarkMode(val);
                        darkModeNotifier.value = val;
                      });
                    },
                  )
                : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
