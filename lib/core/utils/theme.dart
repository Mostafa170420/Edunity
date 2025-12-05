import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDarkColor,
      onSurface: AppColors.darkColor,
      onPrimary: AppColors.darkgreyColor,
      surface: AppColors.whiteColor,
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
        borderSide:
            BorderSide(color: AppColors.darkColor.withAlpha(20), width: 0.7),
      ),
    ),
    cardColor: AppColors.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDarkColor,
      onPrimary: AppColors.darkTextColor,
      surface: AppColors.darkSurfaceColor,
      onSurface: AppColors.darkTextColor,
      secondary: AppColors.primaryLightColor,
      onSecondary: AppColors.darkTextColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.darkTextColor,
      backgroundColor: AppColors.darkBackgroundColor,
      iconTheme: IconThemeData(color: AppColors.darkTextColor),
      titleTextStyle: TextStyles.getBody(
        color: AppColors.darkTextColor,
      ).copyWith(fontFamily: 'Mulish'),
    ),
    fontFamily: 'Mulish',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDarkColor,
        foregroundColor: AppColors.darkTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkTextColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkTextColor,
        side: BorderSide(color: AppColors.darkBorderColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceColor,
      hintStyle:
          TextStyles.getBody(color: AppColors.darkGreyColor, fontSize: 16),
      labelStyle: TextStyles.getBody(color: AppColors.darkTextColor),
      suffixIconColor: AppColors.darkGreyColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primaryDarkColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.darkBorderColor, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.darkGreyColor, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.darkBorderColor, width: 1),
      ),
    ),
    cardColor: AppColors.darkSurfaceColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkSurfaceColor,
      selectedItemColor: AppColors.primaryDarkColor,
      unselectedItemColor: AppColors.darkGreyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBorderColor,
      thickness: 1,
      space: 1,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.darkSurfaceColor,
      textColor: AppColors.darkTextColor,
      iconColor: AppColors.darkTextColor,
    ),
  );
}
