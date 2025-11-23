import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_assets.dart';
import '../utils/colors.dart';

enum DialogeType { success, error }

showMyDialoge(
  BuildContext context,
  String message, {
  DialogeType type = DialogeType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      backgroundColor:
          type == DialogeType.error ? Colors.red : AppColors.primaryDarkColor,
      content: Text(message),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(child: Lottie.asset(AppAssets.loadingJson)),
  );
}
