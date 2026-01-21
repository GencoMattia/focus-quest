import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_animations.dart';

enum AnimatedButtonType { primary, secondary, tertiary, outlined, ghost, gradient }
enum AnimatedButtonSize { small, medium, large }

/// An enhanced button with animations and gradient support
class AnimatedCalmButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AnimatedButtonType type;
  final AnimatedButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final Gradient? gradient;

  const AnimatedCalmButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AnimatedButtonType.primary,
    this.size = AnimatedButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.gradient,
  });

  @override
  State<AnimatedCalmButton> createState() => _AnimatedCalmButtonState();
}

class _AnimatedCalmButtonState extends State<AnimatedCalmButton> 
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isHovered = false;
  late AnimationController _shimmerController;
  
  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }
  
  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    if (widget.gradient != null || widget.type == AnimatedButtonType.gradient) {
      return Colors.transparent;
    }
    switch (widget.type) {
      case AnimatedButtonType.primary:
        return AppColors.primary;
      case AnimatedButtonType.secondary:
        return AppColors.secondary;
      case AnimatedButtonType.tertiary:
        return AppColors.accent;
      case AnimatedButtonType.outlined:
      case AnimatedButtonType.ghost:
        return Colors.transparent;
      case AnimatedButtonType.gradient:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (widget.type) {
      case AnimatedButtonType.primary:
      case AnimatedButtonType.secondary:
        return AppColors.textOnColor;
      case AnimatedButtonType.tertiary:
      case AnimatedButtonType.gradient:
        return AppColors.textPrimary;
      case AnimatedButtonType.outlined:
        return AppColors.primary;
      case AnimatedButtonType.ghost:
        return AppColors.textSecondary;
    }
  }

  BorderSide? _getBorder() {
    if (widget.type == AnimatedButtonType.outlined) {
      return const BorderSide(color: AppColors.primary, width: 2);
    }
    return null;
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case AnimatedButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceSm,
        );
      case AnimatedButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceLg,
          vertical: AppTheme.spaceMd,
        );
      case AnimatedButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceXl,
          vertical: AppTheme.spaceMd + AppTheme.spaceXs,
        );
    }
  }

  double _getMinHeight() {
    switch (widget.size) {
      case AnimatedButtonSize.small:
        return 36;
      case AnimatedButtonSize.medium:
        return 48;
      case AnimatedButtonSize.large:
        return 56;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case AnimatedButtonSize.small:
        return 13;
      case AnimatedButtonSize.medium:
        return 15;
      case AnimatedButtonSize.large:
        return 16;
    }
  }
  
  Gradient? _getGradient() {
    if (widget.gradient != null) return widget.gradient;
    if (widget.type == AnimatedButtonType.gradient) {
      return AppColors.primaryGradient;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getGradient();
    
    final button = AnimatedScale(
      scale: _isPressed ? AppAnimations.pressScale : (_isHovered ? 1.02 : 1.0),
      duration: AppAnimations.fast,
      curve: AppAnimations.easeOut,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        decoration: gradient != null
            ? BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: _getBorder() != null 
                    ? Border.all(color: _getBorder()!.color, width: _getBorder()!.width)
                    : null,
                boxShadow: widget.type != AnimatedButtonType.ghost && 
                           widget.type != AnimatedButtonType.outlined
                    ? [
                        BoxShadow(
                          color: _isHovered ? AppColors.shadowMedium : AppColors.shadow,
                          offset: Offset(0, _isHovered ? 3 : 2),
                          blurRadius: _isHovered ? 8 : 4,
                        ),
                      ]
                    : null,
              )
            : null,
        child: Material(
          color: gradient == null ? _getBackgroundColor() : Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            side: _getBorder() ?? BorderSide.none,
          ),
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onHover: (hovering) => setState(() => _isHovered = hovering),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            child: Container(
              padding: _getPadding(),
              constraints: BoxConstraints(minHeight: _getMinHeight()),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: _getFontSize() + 2, color: _getTextColor()),
                          const SizedBox(width: AppTheme.spaceSm),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: _getFontSize(),
                            fontWeight: FontWeight.w600,
                            color: _getTextColor(),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

    return widget.fullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
