import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

const double kExpandedHeight = 180.0;
const double kCollapsedHeight = 83.0;
const double kMaxTitleBottomPadding = 28.0;

class CustomSliverAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const CustomSliverAppBar({
    super.key,
    required this.userName,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: false,
      backgroundColor: AppColors.backgroundColor,
      elevation: 4,
      automaticallyImplyLeading: false,
      shadowColor: AppColors.primaryDarkColor.withValues(alpha: 0.15),
      forceElevated: true,
      centerTitle: false,
      expandedHeight: kExpandedHeight,
      collapsedHeight: kCollapsedHeight,
      actionsPadding: const EdgeInsets.only(top: 20),
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.none,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        final double currentHeight = constraints.maxHeight;
        final double stretchRatio = (currentHeight - kToolbarHeight) /
            (kExpandedHeight - kToolbarHeight);

        final double bottomPadding =
            (kMaxTitleBottomPadding / 0.9) * stretchRatio.clamp(0.0, 1.0);

        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
              left: 15, right: 15, top: 0, bottom: bottomPadding),
          title: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding * 0.6),
            child: Text.rich(
              TextSpan(
                text: 'Hi, ',
                style: TextStyles.getTitle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: userName,
                    style: TextStyles.getSmall(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDarkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryLightColor.withOpacity(0.15),
                  AppColors.primaryDarkColor.withOpacity(0.8),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
            alignment: Alignment.bottomLeft,
            child: Text(
              'What would you like to learn today?\nSearch below.',
              style: TextStyles.getTitle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
            ),
          ),
        );
      }),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.darkgreyColor.withOpacity(0.6),
              width: 2,
            ),
          ),
          child: Badge(
            backgroundColor: AppColors.redColor,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onNotificationTap ??
                  () => pushTo(context, Routes.notifications),
              icon: Icon(
                IconlyBroken.notification,
                color: AppColors.darkgreyColor,
                size: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
