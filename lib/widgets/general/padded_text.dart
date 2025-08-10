import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final EdgeInsets padding;
  final String text;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const PaddedText(
    this.text, {
    super.key,
    this.textStyle,
    this.padding = const EdgeInsets.only(bottom: 8),
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: textStyle ?? defaultTextStyle,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}
