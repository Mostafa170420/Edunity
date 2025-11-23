import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_assets.dart';
import '../utils/colors.dart';

/// An enumeration of the possible dialog types.
enum DialogeType { success, error }

/// Shows a customizable dialog message.
///
/// * [context]: The build context.
/// * [message]: The message to display.
/// * [type]: The type of dialog to show (success or error).
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
      backgroundColor:
          type == DialogeType.error ? Colors.red : AppColors.primaryDarkColor,
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
    builder: (context) => Center(child: Lottie.asset(AppAssets.loadingJson)),
  );
}
