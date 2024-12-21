import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get getApplicationLightTheme => FlexThemeData.light(
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        scheme: FlexScheme.blueM3,
        scaffoldBackground: AppColors.backgroundLight,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        textTheme: AppTextTheme.lightTextTheme,
        appBarStyle: FlexAppBarStyle.scaffoldBackground,
        fontFamily: 'NeoSansArabic',
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).copyWith(
          highlightColor: AppColors.highlightColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  textStyle: TextStyle(fontSize: 16, color: AppColors.textDark),
                  foregroundColor: AppColors.textDark,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))));

  static ThemeData get getApplicationDarkTheme => FlexThemeData.dark(
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        scheme: FlexScheme.blueM3,
        scaffoldBackground: AppColors.backgroundDark,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        textTheme: AppTextTheme.darkTextTheme,
        appBarStyle: FlexAppBarStyle.scaffoldBackground,
        fontFamily: 'NeoSansArabic',
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).copyWith(
          highlightColor: AppColors.highlightColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.textDark,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: TextStyle(fontSize: 16, color: AppColors.textDark),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))));
}
