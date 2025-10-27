import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/home/presentation/page/home_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/main.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      MyCourses(),
      Center(child: Text("chat")),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.homeSvg,
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter:
              ColorFilter.mode(AppColors.primaryLightColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.homeSvg,
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryLightColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.coursesSvg,
          fit: BoxFit.contain,
          width: 26,
          height: 26,
          colorFilter:
              ColorFilter.mode(AppColors.primaryLightColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.coursesSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        title: ("My Courses"),
        activeColorPrimary: AppColors.primaryLightColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.chatSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(AppColors.primaryLightColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.chatSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        title: ("Chat"),
        activeColorPrimary: AppColors.primaryLightColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.profileSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(AppColors.primaryLightColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.profileSvg,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryLightColor,
        inactiveColorPrimary: Colors.grey,
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
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(110),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          
        ]
      ),
      padding: EdgeInsets.only(top: 4),
      navBarStyle: NavBarStyle.style14, // many styles available
      navBarHeight: 60,
    );
  }
}
