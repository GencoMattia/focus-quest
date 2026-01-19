import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:focus_quest/core/theme/app_colors.dart';

class AppTypography {
  static TextTheme get textTheme => GoogleFonts.nunitoTextTheme().copyWith(
    displayLarge: GoogleFonts.nunito(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: 18,
      color: AppColors.textDark,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 16,
      color: AppColors.textLight,
      height: 1.5,
    ),
  );
}
