import 'package:flutter/material.dart';

import '../general/text_heading_medium.dart';

class Biography extends StatelessWidget {
  final String bio;
  const Biography(
    this.bio, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textPrimaryColor = theme.colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const TextHeadingMedium('Biography'),
        const SizedBox(height: 4),
        Text(
          bio,
          style: textTheme.bodyLarge!
              .copyWith(fontSize: 19, color: textPrimaryColor),
        )
      ],
    );
  }
}
