import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';

enum CalmButtonType { primary, secondary, tertiary, outlined, ghost, gradient }
enum CalmButtonSize { small, medium, large }

class CalmButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final CalmButtonType type;
  final CalmButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final Gradient? gradient;

  const CalmButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CalmButtonType.primary,
    this.size = CalmButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.gradient,
  });

  @override
  State<CalmButton> createState() => _CalmButtonState();
}

class _CalmButtonState extends State<CalmButton> {
  bool _isHovered = false;

  Color _getBackgroundColor() {
    if (widget.gradient != null || widget.type == CalmButtonType.gradient) {
      return Colors.transparent;
    }
    switch (widget.type) {
      case CalmButtonType.primary:
        return AppColors.primary;
      case CalmButtonType.secondary:
        return AppColors.secondary;
      case CalmButtonType.tertiary:
        return AppColors.accent;
      case CalmButtonType.outlined:
      case CalmButtonType.ghost:
        return Colors.transparent;
      case CalmButtonType.gradient:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (widget.type) {
      case CalmButtonType.primary:
      case CalmButtonType.secondary:
        return AppColors.textOnColor;
      case CalmButtonType.tertiary:
      case CalmButtonType.gradient:
        return AppColors.textPrimary;
      case CalmButtonType.outlined:
        return AppColors.primary;
      case CalmButtonType.ghost:
        return AppColors.textSecondary;
    }
  }

  BorderSide? _getBorder() {
    if (widget.type == CalmButtonType.outlined) {
      return const BorderSide(color: AppColors.primary, width: 2);
    }
    return null;
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case CalmButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceSm,
        );
      case CalmButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceLg,
          vertical: AppTheme.spaceMd,
        );
      case CalmButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceXl,
          vertical: AppTheme.spaceMd + AppTheme.spaceXs,
        );
    }
  }

  double _getMinHeight() {
    switch (widget.size) {
      case CalmButtonSize.small:
        return 36;
      case CalmButtonSize.medium:
        return 48;
      case CalmButtonSize.large:
        return 56;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case CalmButtonSize.small:
        return 13;
      case CalmButtonSize.medium:
        return 15;
      case CalmButtonSize.large:
        return 16;
    }
  }
  
  Gradient? _getGradient() {
    if (widget.gradient != null) return widget.gradient;
    if (widget.type == CalmButtonType.gradient) {
      return AppColors.primaryGradient;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getGradient();
    
    final button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: gradient != null
            ? BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: widget.type != CalmButtonType.ghost && 
                           widget.type != CalmButtonType.outlined
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
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: gradient == null ? _getBackgroundColor() : Colors.transparent,
            foregroundColor: _getTextColor(),
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              side: _getBorder() ?? BorderSide.none,
            ),
            padding: _getPadding(),
            minimumSize: Size(0, _getMinHeight()),
          ),
          child: widget.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                  ),
                )
              : Row(
                  mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: _getFontSize() + 2),
                      const SizedBox(width: AppTheme.spaceSm),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: _getFontSize(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
