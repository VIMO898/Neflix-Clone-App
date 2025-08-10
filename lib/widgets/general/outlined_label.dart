import 'package:flutter/material.dart';

class OutlinedLabel extends StatelessWidget {
  final String text;
  final Color? filledColor;
  final bool selected;
  final IconData selectedIcon;
  final int? number;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  const OutlinedLabel(
    this.text, {
    super.key,
    this.filledColor,
    this.margin,
    this.selected = false,
    this.selectedIcon = Icons.done,
    this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final borderRadius = BorderRadius.circular(10);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: !selected
              ? EdgeInsets.symmetric(vertical: 5, horizontal: 14)
              : EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          decoration: BoxDecoration(
            border: !selected ? Border.all(color: colorScheme.secondary) : null,
            borderRadius: borderRadius,
            color: !selected
                ? null
                : filledColor ?? theme.primaryColor.withValues(alpha: 0.35),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    selectedIcon,
                    color: colorScheme.secondary,
                    size: 20,
                  ),
                ),
              Text(
                text,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              if (number != null)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: theme.primaryColor.withValues(alpha: 0.4),
                    child: Text(
                      number!.toString(),
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
