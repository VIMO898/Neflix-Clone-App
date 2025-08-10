import 'package:flutter/material.dart';

class TextHeadingMedium extends StatelessWidget {
  final String text;
  const TextHeadingMedium(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textPrimaryColor = theme.colorScheme.primary;
    return Text(text,
        style: textTheme.titleLarge!
            .copyWith(fontSize: 24, color: textPrimaryColor));
  }
}
