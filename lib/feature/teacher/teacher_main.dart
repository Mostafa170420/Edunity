import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/chat/page/all_chats_screen.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:edunity/feature/teacher/my%20courses/presentation/pages/teacher_course_page.dart';
import 'package:edunity/feature/teacher/home/teacher_homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

void main() {
  runApp(const TeacherApp());
}

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryDarkColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: const TeacherMainScreen(),
    );
  }
}

class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({super.key});

  @override
  _TeacherMainScreenState createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // Screens for each tab
  List<Widget> _buildScreens() {
    return [
      TeacherHomePage(),
      TeacherCoursePage(),
      ChatsScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    Color activeColor = AppColors.primaryDarkColor;
    Color inactiveColor = AppColors.greyColor;

    return [
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
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: false,
      padding: EdgeInsets.only(
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: 90,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryDarkColor.withAlpha(40),
            AppColors.primaryLightColor.withAlpha(50),
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
      navBarStyle: NavBarStyle.style14,
    );
  }
}
