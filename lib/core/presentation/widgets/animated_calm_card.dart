import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_animations.dart';

/// An animated card that slides in and fades in on mount
class AnimatedCalmCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final double? elevation;
  final Duration delay;
  final bool enableHoverEffect;
  
  const AnimatedCalmCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.gradient,
    this.padding,
    this.margin,
    this.border,
    this.elevation,
    this.delay = Duration.zero,
    this.enableHoverEffect = true,
  });

  @override
  State<AnimatedCalmCard> createState() => _AnimatedCalmCardState();
}

class _AnimatedCalmCardState extends State<AnimatedCalmCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.normal,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.fastOutSlowIn,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.easeOut,
    ));
    
    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedScale(
            scale: _isPressed ? AppAnimations.pressScale : (_isHovered && widget.enableHoverEffect ? AppAnimations.hoverScale : 1.0),
            duration: AppAnimations.fast,
            curve: AppAnimations.easeOut,
            child: Container(
              margin: widget.margin ?? const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: widget.gradient == null ? (widget.color ?? AppColors.surface) : null,
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                border: widget.border,
                boxShadow: [
                  BoxShadow(
                    color: _isHovered ? AppColors.shadowMedium : AppColors.shadow,
                    offset: Offset(0, _isHovered ? 4 : 2),
                    blurRadius: (widget.elevation ?? 8) + (_isHovered ? 4 : 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) => setState(() => _isPressed = false),
                  onTapCancel: () => setState(() => _isPressed = false),
                  onHover: (hovering) {
                    if (widget.enableHoverEffect) {
                      setState(() => _isHovered = hovering);
                    }
                  },
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  child: Padding(
                    padding: widget.padding ?? const EdgeInsets.all(AppTheme.spaceMd),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
