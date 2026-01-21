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
  
  // Backgrounds
  static const Color background = Color(0xFFFAFAFA); // Slightly warmer white
  static const Color surface = Color(0xFFFFFFFF); // Pure white for cards
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light grey

  // Accents (Non-aggressive)
  static const Color softPink = Color(0xFFFFDFD3);
  static const Color peach = Color(0xFFFEC8D8);
  static const Color warmBeige = Color(0xFFFFF4E6); // New: warm neutral

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
  static const Color overlay = Color(0x80000000); // 50% black for dialogs
  static const Color divider = Color(0xFFE0E0E0); // Subtle divider

  // Legacy aliases for backward compatibility
  static const Color calmBlue = primary;
  static const Color sageGreen = secondary;
  static const Color lilac = accent;
  static const Color warmGrey = background;
  static const Color textDark = textPrimary;
  static const Color textLight = textSecondary;
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
