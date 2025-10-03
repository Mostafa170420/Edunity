import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(color: AppColors.primaryDarkColor),
      titleTextStyle: TextStyles.getBody(
        color: AppColors.darkColor,
      ).copyWith(fontFamily: 'Mulish'),
    ),
    fontFamily: 'Mulish',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDarkColor,
      onSurface: AppColors.darkColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.darkColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintStyle: TextStyles.getBody(color: AppColors.greyColor, fontSize: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );
}
