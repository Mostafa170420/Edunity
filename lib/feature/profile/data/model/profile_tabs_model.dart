import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/routes.dart';

class ProfileTabsModel {
  final String? title;
  final String? icon;
  final String? route;

  ProfileTabsModel({
    this.title,
    this.icon,
    this.route,
  });
}

final List<ProfileTabsModel> profileOptions = [
  ProfileTabsModel(
      title: 'Edit Profile',
      icon: AppAssets.profileSvg,
      route: Routes.editProfile),
  ProfileTabsModel(
      title: 'Bookmarks',
      icon: AppAssets.bookmarkOutlineSvg,
      route: Routes.bookmark),
  ProfileTabsModel(
    title: 'Dark Mode',
    icon: AppAssets.darkModeSvg,
  ),
  ProfileTabsModel(
    title: 'Notifications',
    icon: AppAssets.notificationSvg,
  ),
  ProfileTabsModel(
    title: 'Language',
    icon: AppAssets.languageSvg,
  ),
  ProfileTabsModel(
    title: 'Payment',
    icon: AppAssets.paymentSvg,
  ),
  ProfileTabsModel(
    title: 'Security',
    icon: AppAssets.securitySvg,
  ),
  ProfileTabsModel(
    title: 'Help Center',
    icon: AppAssets.helpCenterSvg,
  ),
  ProfileTabsModel(
    title: 'Terms & Conditions',
    icon: AppAssets.termsSvg,
  ),
];
