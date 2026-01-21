import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette - Vibrant & Modern
  static const Color primaryBlue = Color(0xFF4A90E2); // Deep Blue
  static const Color primaryBlueDark = Color(0xFF357ABD); // Darker Blue for gradients
  static const Color vibrantGreen = Color(0xFF10B981); // Emerald Green
  static const Color energeticPurple = Color(0xFF8B5CF6); // Vivid Purple
  static const Color warmOrange = Color(0xFFF59E0B); // Amber Orange
  
  // Background
  static const Color backgroundLight = Color(0xFFFAFAFA); // Very light gray
  static const Color backgroundWhite = Color(0xFFFFFFFF); // Pure white
  static const Color cardBackground = Color(0xFFFFFFFF); // Card white
  
  // Accent Colors
  static const Color accentPink = Color(0xFFEC4899); // Hot Pink
  static const Color accentPinkDark = Color(0xFFBE185D); // Deep Pink
  static const Color accentTeal = Color(0xFF14B8A6); // Teal
  static const Color accentIndigo = Color(0xFF6366F1); // Indigo

  // Text
  static const Color textDark = Color(0xFF1F2937); // Rich dark gray
  static const Color textMedium = Color(0xFF6B7280); // Medium gray
  static const Color textLight = Color(0xFF9CA3AF); // Light gray
  
  // Status Colors - More saturated
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [vibrantGreen, Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [energeticPurple, Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [accentPink, accentPinkDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF9FAFB), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Urgency Colors
  static const Color urgencyHigh = Color(0xFFEF4444); // Red
  static const Color urgencyMedium = Color(0xFFF59E0B); // Amber
  static const Color urgencyLow = Color(0xFF10B981); // Green
}
