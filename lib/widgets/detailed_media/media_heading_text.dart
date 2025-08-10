import 'package:flutter/material.dart';

class MediaHeadingText extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  const MediaHeadingText(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.only(bottom: 14),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
