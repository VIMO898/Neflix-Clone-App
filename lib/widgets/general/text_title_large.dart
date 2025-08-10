import 'package:flutter/material.dart';

class TextTitleLarge extends StatelessWidget {
  final double? customFontSize;
  final String text;
  const TextTitleLarge(this.text, {super.key, this.customFontSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textPrimaryColor = theme.colorScheme.primary;
    return Text(
      text,
      style: textTheme.titleLarge!
          .copyWith(fontSize: customFontSize, color: textPrimaryColor),
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
