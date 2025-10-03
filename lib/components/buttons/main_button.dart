import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
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
  final String title;
  final Function() onPressed;
  final double width;
  final double height;
  final double fontSize;
  final Color bgcolor;
  final Color textColor;
  final Color? borderColor;
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
