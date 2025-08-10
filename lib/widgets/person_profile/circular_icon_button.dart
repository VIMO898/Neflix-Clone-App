import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final double radius;
  final double iconSize;
  final VoidCallback onTap;
  const CircularIconButton({
    super.key,
    this.radius = 20.0,
    this.iconSize = 24.0,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      radius: radius,
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: theme.cardColor,
        radius: radius,
        child: Icon(icon, size: iconSize, color: theme.colorScheme.primary),
      ),
    );
  }
}
