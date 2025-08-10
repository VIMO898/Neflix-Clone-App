import 'package:flutter/material.dart';

class FullWidthElevatedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback onTap;
  const FullWidthElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.margin = const EdgeInsets.only(top: 8),
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ElevatedButton.styleFrom(
      padding: padding,
      backgroundColor: theme.primaryColor,
    );
    final buttonLabelStyle = theme.textTheme.titleSmall?.copyWith(
      // color: theme.scaffoldBackgroundColor,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    return Container(
      width: double.infinity,
      margin: margin,
      child: icon == null
          ? ElevatedButton(
              onPressed: onTap,
              style: buttonStyle,
              child: Text(text, style: buttonLabelStyle),
            )
          : ElevatedButton.icon(
              onPressed: onTap,
              style: buttonStyle,
              icon: Icon(icon, size: 26, color: Colors.white),
              label: Text(text, style: buttonLabelStyle),
            ),
    );
  }
}
