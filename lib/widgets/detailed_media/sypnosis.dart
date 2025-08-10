import 'package:flutter/material.dart';

import '../general/expandable_text.dart';
import 'media_heading_text.dart';

class Sypnosis extends StatelessWidget {
  final String sypnosis;
  const Sypnosis(this.sypnosis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MediaHeadingText('Synopsis'),
          ExpandableText(sypnosis,
              padding: const EdgeInsets.only(bottom: 25), maxLines: 4),
        ]);
  }
}
