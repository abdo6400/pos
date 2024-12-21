import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static TextTheme get lightTextTheme => const TextTheme(
        displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: AppColors.textLight),
        displayMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: AppColors.textLight),
        displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.textLight),
        headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textLight),
        headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textLight),
        headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textLight),
        titleLarge: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: AppColors.textLight),
        titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textLight),
        titleSmall: TextStyle(fontSize: 16, color: AppColors.textLight),
        bodyLarge: TextStyle(fontSize: 14, color: AppColors.textLight),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textLight),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textLight),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textLight),
        labelMedium: TextStyle(fontSize: 12, color: AppColors.textLight),
        labelSmall: TextStyle(fontSize: 10, color: AppColors.textLight),
      );

  static TextTheme get darkTextTheme => const TextTheme(
        displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: AppColors.textDark),
        displayMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: AppColors.textDark),
        displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.textDark),
        headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark),
        headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark),
        headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark),
        titleLarge: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark),
        titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark),
        titleSmall: TextStyle(fontSize: 16, color: AppColors.textDark),
        bodyLarge: TextStyle(fontSize: 14, color: AppColors.textDark),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textDark),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textDark),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark),
        labelMedium: TextStyle(fontSize: 12, color: AppColors.textDark),
        labelSmall: TextStyle(fontSize: 10, color: AppColors.textDark),
      );
}
