import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';

enum CalmButtonType { primary, secondary, tertiary, outlined, ghost }
enum CalmButtonSize { small, medium, large }

class CalmButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CalmButtonType type;
  final CalmButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  const CalmButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CalmButtonType.primary,
    this.size = CalmButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case CalmButtonType.primary:
        return AppColors.primary;
      case CalmButtonType.secondary:
        return AppColors.secondary;
      case CalmButtonType.tertiary:
        return AppColors.accent;
      case CalmButtonType.outlined:
      case CalmButtonType.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case CalmButtonType.primary:
      case CalmButtonType.secondary:
        return AppColors.textOnColor;
      case CalmButtonType.tertiary:
        return AppColors.textPrimary;
      case CalmButtonType.outlined:
        return AppColors.primary;
      case CalmButtonType.ghost:
        return AppColors.textSecondary;
    }
  }

  BorderSide? _getBorder() {
    if (type == CalmButtonType.outlined) {
      return BorderSide(color: AppColors.primary, width: 2);
    }
    return null;
  }

  EdgeInsets _getPadding() {
    switch (size) {
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
    switch (size) {
      case CalmButtonSize.small:
        return 36;
      case CalmButtonSize.medium:
        return 48;
      case CalmButtonSize.large:
        return 56;
    }
  }

  double _getFontSize() {
    switch (size) {
      case CalmButtonSize.small:
        return 13;
      case CalmButtonSize.medium:
        return 15;
      case CalmButtonSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getTextColor(),
        elevation: type == CalmButtonType.ghost ? 0 : (type == CalmButtonType.outlined ? 0 : 0),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          side: _getBorder() ?? BorderSide.none,
        ),
        padding: _getPadding(),
        minimumSize: Size(0, _getMinHeight()),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
              ),
            )
          : Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: _getFontSize() + 2),
                  const SizedBox(width: AppTheme.spaceSm),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: _getFontSize(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );

    return fullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
