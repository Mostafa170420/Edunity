import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/chat/page/all_chats_screen.dart';
import 'package:edunity/feature/home/presentation/page/home_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/my_courses_page.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(userType: widget.userType),
      MyCourses(),
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
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.homeSvg,
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("Home"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.coursesSvg,
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.coursesSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("My Courses"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.chatSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.chatSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        title: ("Chat"),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.profileSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.profileSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
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
      confineToSafeArea: false, // false to make pages behind nav bar
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
          // borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
              colors: [
                AppColors.primaryDarkColor.withAlpha(40),
                AppColors.primaryLightColor.withAlpha(50)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              transform: GradientRotation(150)),
          useBackdropFilter: true,
          // colorBehindNavBar: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(22)),
          boxShadow: [
            BoxShadow(
              color: AppColors.whiteColor.withAlpha(150),
              blurRadius: 0,
              offset: const Offset(0, 0),
            ),
          ]),
      padding: EdgeInsets.only(top: 12, bottom: 20),
      navBarStyle: NavBarStyle.style14, // many styles available
      navBarHeight: 90,
    );
  }
}
