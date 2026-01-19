import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';

enum CalmButtonType { primary, secondary, ghost }

class CalmButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CalmButtonType type;
  final IconData? icon;

  const CalmButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CalmButtonType.primary,
    this.icon,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case CalmButtonType.primary:
        return AppColors.calmBlue;
      case CalmButtonType.secondary:
        return AppColors.sageGreen;
      case CalmButtonType.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case CalmButtonType.ghost:
        return AppColors.textLight;
      default:
        return AppColors.textDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          foregroundColor: _getTextColor(),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
