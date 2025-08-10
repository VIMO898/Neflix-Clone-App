import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final EdgeInsets padding;
  final bool hideIcon;
  final Color? iconColor;
  final VoidCallback? onRefresh;

  const CenteredMessage({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 80),
    this.icon = Icons.error_outline,
    this.title = "Something went wrong",
    this.subtitle = "Please try again later",
    this.iconColor,
    this.hideIcon = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!hideIcon)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Icon(icon, size: 120, color: iconColor),
              ),
            Text(
              title,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.2, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null)
              Container(
                padding: const EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: onRefresh,
                  icon: Icon(Icons.refresh),
                  label: Text('Refresh'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
