import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  const ExpandableText(
    this.text, {
    super.key,
    this.padding = EdgeInsets.zero,
    required this.maxLines,
    this.textStyle,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _handleToggleTextExpanded() {
    _isExpanded = !_isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    final textStyle =
        widget.textStyle ?? textTheme.bodyMedium?.copyWith(height: 1.4);
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              widget.text,
              style: textStyle,
              maxLines: widget.maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(widget.text, style: textStyle),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: _handleToggleTextExpanded,
              child: Text(
                _isExpanded ? 'Read Less' : 'Read More',
                style: textTheme.bodySmall?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
