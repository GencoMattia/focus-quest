import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.warmGrey,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.calmBlue,
        primary: AppColors.calmBlue,
        secondary: AppColors.sageGreen,
        tertiary: AppColors.lilac,
        background: AppColors.warmGrey,
        surface: Colors.white,
      ),
      textTheme: AppTypography.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1, // Subtle lift
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Softer, bigger radius
          side: const BorderSide(color: Colors.transparent),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.calmBlue,
          foregroundColor: AppColors.textDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20),
        prefixIconColor: AppColors.textLight,
      ),
    );
  }
}
