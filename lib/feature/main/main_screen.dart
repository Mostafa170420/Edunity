// Import necessary packages and widgets for the main screen.
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/chat/page/all_chats_screen.dart';
import 'package:edunity/feature/home/presentation/page/home_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/my_courses_page.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

/// The `MainScreen` is a stateful widget that serves as the main container for the app's
/// primary features, accessible through a persistent bottom navigation bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

/// The state class for the `MainScreen` widget. It manages the bottom navigation
/// bar and the currently displayed screen.
class BottomNavBarState extends State<MainScreen> {
  // A controller for the persistent bottom navigation bar to manage the selected tab.
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  /// Builds the list of screens to be displayed in the bottom navigation bar.
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const MyCourses(),
      const ChatsScreen(),
      const ProfileScreen(),
    ];
  }

  /// Builds the list of items for the bottom navigation bar.
  /// Each item corresponds to a screen in the `_buildScreens` list.
  List<PersistentBottomNavBarItem> _navBarsItems() {
    Color activeColor = AppColors.primaryDarkColor;
    Color inactiveColor = AppColors.greyColor;

    return [
      // Home screen navigation item.
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.homeSvg,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.homeSvg,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("Home"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      // "My Courses" screen navigation item.
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.coursesSvg,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.coursesSvg,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("My Courses"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      // Chat screen navigation item.
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.chatSvg,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.chatSvg,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("Chat"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      // Profile screen navigation item.
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.profileSvg,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.profileSvg,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("Profile"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // The `PersistentTabView` is the main widget for the persistent bottom navigation bar.
    return PersistentTabView(
      context,
      controller: _controller, // The controller for the tab view.
      screens: _buildScreens(), // The screens to be displayed.
      items: _navBarsItems(), // The items for the navigation bar.
      confineToSafeArea: false, // Ensures the content is within the safe area.
      padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context)
              .padding
              .bottom), // Padding around the content.

      backgroundColor:
          Colors.white, // The background color of the navigation bar.
      handleAndroidBackButtonPress:
          true, // Handles the back button press on Android.
      resizeToAvoidBottomInset: true, // Resizes the body to avoid the keyboard.
      stateManagement:
          true, // This preserves the state of each tab when switching.
      navBarHeight: 90, // The height of the navigation bar.
      hideNavigationBarWhenKeyboardAppears:
          true, // Hides the navigation bar when the keyboard appears
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryDarkColor.withAlpha(40),
            AppColors.primaryLightColor.withAlpha(50)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.whiteColor.withAlpha(150),
            blurRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      navBarStyle:
          NavBarStyle.style14, // Sets the visual style of the navigation bar.
    );
  }
}
