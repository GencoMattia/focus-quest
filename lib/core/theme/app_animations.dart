import 'package:flutter/material.dart';

/// Animation constants and utilities for the app
class AppAnimations {
  // Duration constants
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
  
  // Common curves
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  
  // Page transitions
  static const Curve pageTransitionCurve = Curves.easeInOutCubic;
  static const Duration pageTransitionDuration = Duration(milliseconds: 350);
  
  // Stagger delays for list animations
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration staggerDelayLong = Duration(milliseconds: 100);
  
  // Scale factors for press animations
  static const double pressScale = 0.95;
  static const double hoverScale = 1.02;
  
  // Fade values
  static const double fadeInStart = 0.0;
  static const double fadeInEnd = 1.0;
  static const double fadeOutStart = 1.0;
  static const double fadeOutEnd = 0.0;
  
  // Slide distances
  static const double slideDistanceShort = 20.0;
  static const double slideDistanceMedium = 40.0;
  static const double slideDistanceLong = 60.0;
}

/// Mixin to simplify animation controller management
mixin SingleTickerProviderStateMixin on State {
  AnimationController? _controller;
  
  AnimationController createController({
    required Duration duration,
    Duration? reverseDuration,
  }) {
    _controller?.dispose();
    _controller = AnimationController(
      vsync: this as TickerProvider,
      duration: duration,
      reverseDuration: reverseDuration,
    );
    return _controller!;
  }
  
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

/// Pre-built animation utilities
class AnimationUtils {
  /// Creates a fade-in animation
  static Animation<double> createFadeIn(AnimationController controller) {
    return Tween<double>(
      begin: AppAnimations.fadeInStart,
      end: AppAnimations.fadeInEnd,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: AppAnimations.easeOut,
    ));
  }
  
  /// Creates a slide-up animation
  static Animation<Offset> createSlideUp(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: AppAnimations.fastOutSlowIn,
    ));
  }
  
  /// Creates a scale animation
  static Animation<double> createScale(AnimationController controller) {
    return Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: AppAnimations.easeOut,
    ));
  }
  
  /// Creates a staggered delay for list items
  static Duration getStaggerDelay(int index, {Duration? baseDelay}) {
    final delay = baseDelay ?? AppAnimations.staggerDelay;
    return delay * index;
  }
}
