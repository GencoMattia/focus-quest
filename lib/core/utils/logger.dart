import 'package:flutter/foundation.dart';

/// Simple logging utility for the application.
/// 
/// This provides a centralized logging mechanism that respects
/// debug/release mode and can be easily extended with proper logging
/// frameworks in the future.
class AppLogger {
  /// Log a debug message
  /// Only logs in debug mode
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('DEBUG: $prefix$message');
    }
  }

  /// Log an info message
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('INFO: $prefix$message');
    }
  }

  /// Log a warning message
  static void warning(String message, [String? tag]) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('WARNING: $prefix$message');
  }

  /// Log an error message
  static void error(String message, [Object? error, StackTrace? stackTrace, String? tag]) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('ERROR: $prefix$message');
    if (error != null) {
      debugPrint('  Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('  StackTrace: $stackTrace');
    }
  }
}
