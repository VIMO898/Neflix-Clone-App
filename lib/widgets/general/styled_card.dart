import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final Color? color;
  final EdgeInsets padding;
  final double borderCircularRadius;
  final EdgeInsets margin;
  final Widget child;
  const StyledCard({
    super.key,
    this.color,
    this.padding = const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
    this.margin = const EdgeInsets.only(bottom: 20.0),
    this.borderCircularRadius = 16.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderCircularRadius),
        color: color ?? theme.cardColor,
      ),
      child: child,
    );
  }
}
