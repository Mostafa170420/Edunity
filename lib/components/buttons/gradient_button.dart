/// A customizable button with a gradient background.
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  /// The text to display on the button.
  final String? label;

  /// An optional icon to display on the button.
  final Widget? icon;

  /// The alignment of the icon relative to the label.
  final IconAlignment? iconAlignment;

  /// The callback function to execute when the button is pressed.
  final VoidCallback? onPressed;

  /// The radius of the button's corners.
  final double borderRadius;

  /// The padding around the button's content.
  final EdgeInsetsGeometry? padding;

  /// The width of the button.
  final double? width;
  final bool? addedToCart;

  /// Creates a new [GradientButton].
  const GradientButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.iconAlignment = IconAlignment.start,
      this.borderRadius = 25,
      this.padding,
      this.width,
      this.addedToCart = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the height of the button, adjusting for vertical padding.
      height: padding?.vertical != null ? 20 + padding!.vertical : 40,
      width: width,
      decoration: BoxDecoration(
        // Create a linear gradient for the button's background.
        gradient: addedToCart == true
            ? LinearGradient(
                colors: [AppColors.greenColor, Colors.greenAccent],
              )
            : LinearGradient(
                colors: [
                  AppColors.primaryLightColor,
                  AppColors.primaryDarkColor
                ],
              ),
        // Set the corner radius of the button.
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: (label == null || label!.isEmpty)
          // If there is no label, create a button with only an icon.
          ? TextButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: icon ?? const SizedBox(),
            )
          // If there is a label, create a button with an icon and a label.
          : TextButton.icon(
              icon: icon,
              iconAlignment: iconAlignment,
              style: ElevatedButton.styleFrom(
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
