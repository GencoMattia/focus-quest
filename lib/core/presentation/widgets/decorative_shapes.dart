import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';

/// Decorative background shapes for modern design
class DecorativeShapes extends StatelessWidget {
  final bool animated;
  
  const DecorativeShapes({
    super.key,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top right blob
        Positioned(
          top: -50,
          right: -50,
          child: animated
              ? _AnimatedBlob(
                  size: 200,
                  color: AppColors.primaryLight.withOpacity(0.3),
                  duration: const Duration(seconds: 4),
                )
              : _StaticBlob(
                  size: 200,
                  color: AppColors.primaryLight.withOpacity(0.3),
                ),
        ),
        // Bottom left blob
        Positioned(
          bottom: -80,
          left: -80,
          child: animated
              ? _AnimatedBlob(
                  size: 250,
                  color: AppColors.secondaryLight.withOpacity(0.3),
                  duration: const Duration(seconds: 5),
                  reverse: true,
                )
              : _StaticBlob(
                  size: 250,
                  color: AppColors.secondaryLight.withOpacity(0.3),
                ),
        ),
        // Center accent
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          right: -60,
          child: animated
              ? _AnimatedBlob(
                  size: 180,
                  color: AppColors.accentLight.withOpacity(0.2),
                  duration: const Duration(seconds: 6),
                )
              : _StaticBlob(
                  size: 180,
                  color: AppColors.accentLight.withOpacity(0.2),
                ),
        ),
      ],
    );
  }
}

class _StaticBlob extends StatelessWidget {
  final double size;
  final Color color;
  
  const _StaticBlob({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0.0),
          ],
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _AnimatedBlob extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final bool reverse;
  
  const _AnimatedBlob({
    required this.size,
    required this.color,
    required this.duration,
    this.reverse = false,
  });

  @override
  State<_AnimatedBlob> createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<_AnimatedBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: widget.reverse);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_controller.value * 0.1),
          child: Transform.rotate(
            angle: _controller.value * 2 * math.pi * 0.1,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    widget.color,
                    widget.color.withOpacity(0.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Geometric pattern background
class GeometricPattern extends StatelessWidget {
  final Color color;
  final double spacing;
  
  const GeometricPattern({
    super.key,
    this.color = AppColors.divider,
    this.spacing = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GeometricPatternPainter(
        color: color,
        spacing: spacing,
      ),
      size: Size.infinite,
    );
  }
}

class _GeometricPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;
  
  _GeometricPatternPainter({
    required this.color,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw grid of circles
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Glassmorphism container effect
class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Border? border;
  
  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.2,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            border: border ?? Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
