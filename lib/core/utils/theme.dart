import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDarkColor,
      onSurface: AppColors.darkColor,
      onPrimary: AppColors.darkgreyColor,
      surface: AppColors.accentColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.backgroundColor,
      iconTheme: IconThemeData(color: AppColors.primaryDarkColor),
      titleTextStyle: TextStyles.getBody(
        color: AppColors.darkColor,
      ).copyWith(fontFamily: 'Mulish'),
    ),
    fontFamily: 'Mulish',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDarkColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.darkColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintStyle: TextStyles.getBody(color: AppColors.greyColor, fontSize: 16),
      suffixIconColor: AppColors.greyColor,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primaryDarkColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.darkColor.withAlpha(20), width: 0.7),
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
