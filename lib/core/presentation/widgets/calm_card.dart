import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';

class CalmCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final double? elevation;
  final bool enableHoverEffect;

  const CalmCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.gradient,
    this.padding,
    this.margin,
    this.border,
    this.elevation,
    this.enableHoverEffect = true,
  });

  @override
  State<CalmCard> createState() => _CalmCardState();
}

class _CalmCardState extends State<CalmCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
      decoration: BoxDecoration(
        color: widget.gradient == null ? (widget.color ?? AppColors.surface) : null,
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: widget.border,
        boxShadow: [
          BoxShadow(
            color: _isHovered && widget.enableHoverEffect ? AppColors.shadowMedium : AppColors.shadow,
            offset: Offset(0, _isHovered && widget.enableHoverEffect ? 4 : 2),
            blurRadius: (widget.elevation ?? 8) + (_isHovered && widget.enableHoverEffect ? 4 : 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
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
    );
  }
}
