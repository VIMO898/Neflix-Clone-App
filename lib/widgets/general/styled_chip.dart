import 'package:flutter/material.dart';

class StyledChip extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? margin;
  const StyledChip({
    super.key,
    this.margin,
    this.color,
    this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      decoration: BoxDecoration(
        color: color ?? primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: textTheme.titleLarge?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
