import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

/// A customizable main button widget.
class MainButton extends StatelessWidget {
  /// Creates a [MainButton].
  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 55,
    this.fontSize = 16,
    this.bgcolor = AppColors.primaryDarkColor,
    this.textColor = AppColors.whiteColor,
    this.borderColor,
    this.borderRadius = 10,
  });

  /// The text to display on the button.
  final String title;

  /// The callback function to execute when the button is pressed.
  final Function() onPressed;

  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The font size of the button's title.
  final double fontSize;

  /// The background color of the button.
  final Color bgcolor;

  /// The color of the button's text.
  final Color textColor;

  /// The color of the button's border.
  final Color? borderColor;

  /// The radius of the button's corners.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          style: TextStyles.getBody(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
