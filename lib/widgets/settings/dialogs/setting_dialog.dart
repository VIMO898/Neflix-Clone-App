import 'package:flutter/material.dart';

class SettingDialog extends StatelessWidget {
  final String title;
  final bool centeredTitle;
  final Widget child;
  final double height;
  final List<Widget>? actions;

  const SettingDialog({
    super.key,
    required this.title,
    required this.child,
    this.centeredTitle = false,
    this.actions,
    this.height = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: theme.cardColor,
      elevation: 4,
      child: Container(
        height: height,
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: centeredTitle ? Alignment.center : Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(title, style: textTheme.titleLarge),
            ),
            Expanded(child: child),
            if (actions != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
