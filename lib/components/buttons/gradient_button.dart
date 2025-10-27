import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final IconAlignment? iconAlignment;
  final VoidCallback? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const GradientButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.icon,
      required this.iconAlignment,
      this.borderRadius = 25,
      this.padding,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      height: padding?.vertical != null ? 20 + padding!.vertical : 40,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDarkColor, AppColors.primaryLightColor],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: (label == null || label!.isEmpty)
          ? TextButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: icon ?? SizedBox(),
            )
          : TextButton.icon(
              icon: icon,
              iconAlignment: iconAlignment,
              style: ElevatedButton.styleFrom(
                // padding: padding ?? const EdgeInsets.all(8.0),
                // padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              onPressed: onPressed,
              label: Text(
                label ?? '',
                style: TextStyles.getSmall(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}
