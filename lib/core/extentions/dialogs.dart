import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_assets.dart';
import '../utils/colors.dart';

enum DialogeType { success, error, warning }

showMyDialoge(
  BuildContext context,
  String message, {
  DialogeType type = DialogeType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: type == DialogeType.error
          ? Colors.red
          : type == DialogeType.warning
              ? AppColors.yellowLightColor
              : AppColors.primaryDarkColor,
      content: Text(message),
    ),
  );
}

/// Shows a loading dialog.
///
/// * [context]: The build context.
showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
        child:
            SizedBox(height: 150, child: Lottie.asset(AppAssets.loadingJson))),
  );
}

void showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Confirm Sign Out',
        style: TextStyles.getBody(),
      ),
      content: Text('Are you sure you want to sign out?',
          style: TextStyles.getBody(fontSize: 15)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyles.getBody(fontSize: 15)),
        ),
        GradientButton(
          onPressed: () {
            pop(context);
            FirebaseAuth.instance.signOut();
            pushToBase(context, Routes.login);
          },
          label: 'Sign Out',
        ),
      ],
    ),
  );
}
