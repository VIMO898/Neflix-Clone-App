import 'package:flutter/material.dart';

class CircleIconWithLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? selectedLabel;
  final IconData? selectedIcon;
  final bool selected;
  final void Function(bool selected) onPressed;
  final double iconSize;
  final double circleRadius;
  final Color? color;
  final Color? iconColor;
  const CircleIconWithLabel({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.selected = false,
    this.selectedLabel,
    this.selectedIcon,
    this.iconColor,
    this.color,
    this.iconSize = 25.0,
    this.circleRadius = 55.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final labelTextStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.primary,
      // fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return GestureDetector(
      onTap: () => onPressed(selected),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _buildCircleIconButton(theme),
          Container(
            width: circleRadius,
            height: circleRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: color ?? colorScheme.primary,
              border: Border.all(color: colorScheme.primary),
            ),
            child: Icon(
              selected ? selectedIcon : icon,
              size: iconSize,
              color: iconColor ?? colorScheme.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            selected ? selectedLabel ?? label : label,
            style: labelTextStyle,
          ),
        ],
      ),
    );
  }

  // Widget _buildCircleIconButton(ThemeData theme) {
  //   final colorScheme = theme.colorScheme;
  //   return ;
  // }
}
