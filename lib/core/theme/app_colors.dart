import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette - Enhanced for better contrast and accessibility
  static const Color primary = Color(0xFF6B9BD1); // Deeper Calm Blue
  static const Color primaryLight = Color(0xFFA8D8EA); // Light Blue
  static const Color primaryDark = Color(0xFF4A7BA7); // Dark Blue
  
  static const Color secondary = Color(0xFF88C9A1); // Enhanced Sage Green
  static const Color secondaryLight = Color(0xFFC0EAC0); // Light Sage
  static const Color secondaryDark = Color(0xFF5FA77C); // Dark Sage
  
  static const Color accent = Color(0xFFD4A5D7); // Enhanced Lilac
  static const Color accentLight = Color(0xFFE0BBE4); // Light Lilac
  static const Color accentDark = Color(0xFFB388B5); // Dark Lilac
  
  // Modern gradient colors
  static const Color gradientStart = Color(0xFF89CFF0); // Sky Blue
  static const Color gradientMid = Color(0xFFA8E6CF); // Mint
  static const Color gradientEnd = Color(0xFFDCD0FF); // Lavender
  
  // Vibrant accent colors for variety
  static const Color coral = Color(0xFFFF6B6B); // Coral Red
  static const Color turquoise = Color(0xFF4ECDC4); // Turquoise
  static const Color amber = Color(0xFFFFA07A); // Light Salmon/Amber
  static const Color mint = Color(0xFF98D8C8); // Mint Green
  static const Color lavender = Color(0xFFB19CD9); // Lavender
  
  // Backgrounds
  static const Color background = Color(0xFFF8F9FA); // Modern light grey-white
  static const Color surface = Color(0xFFFFFFFF); // Pure white for cards
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light grey
  static const Color surfaceTinted = Color(0xFFF0F7FF); // Tinted surface

  // Accents (Non-aggressive)
  static const Color softPink = Color(0xFFFFDFD3);
  static const Color peach = Color(0xFFFEC8D8);
  static const Color warmBeige = Color(0xFFFFF4E6); // New: warm neutral
  
  // Gradient presets
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF89CFF0), Color(0xFF6B9BD1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFA8E6CF), Color(0xFF88C9A1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFE0BBE4), Color(0xFFD4A5D7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF89CFF0), Color(0xFFA8E6CF), Color(0xFFDCD0FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Text - Improved hierarchy
  static const Color textPrimary = Color(0xFF1A1A1A); // Darker for better readability
  static const Color textSecondary = Color(0xFF666666); // Medium grey
  static const Color textTertiary = Color(0xFF999999); // Light grey
  static const Color textOnColor = Color(0xFFFFFFFF); // White text on colored backgrounds

  // Status - Enhanced
  static const Color success = Color(0xFF4CAF50); // More standard green
  static const Color successLight = Color(0xFF81C784); // Light green
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color warningLight = Color(0xFFFFE082); // Light amber
  static const Color error = Color(0xFFEF5350); // Soft red
  static const Color errorLight = Color(0xFFFF8A80); // Light red
  static const Color info = Color(0xFF42A5F5); // Info blue

  // Shadows and Overlays
  static const Color shadow = Color(0x1A000000); // 10% black
  static const Color shadowMedium = Color(0x26000000); // 15% black
  static const Color shadowHeavy = Color(0x33000000); // 20% black
  static const Color overlay = Color(0x80000000); // 50% black for dialogs
  static const Color divider = Color(0xFFE0E0E0); // Subtle divider

  // Legacy aliases for backward compatibility
  static const Color calmBlue = primary;
  static const Color sageGreen = secondary;
  static const Color lilac = accent;
  static const Color warmGrey = background;
  static const Color textDark = textPrimary;
  static const Color textLight = textSecondary;
}
