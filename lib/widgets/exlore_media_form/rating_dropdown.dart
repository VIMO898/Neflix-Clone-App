import 'package:flutter/material.dart';

import '../general/padded_text.dart';
import '../general/primary_drop_down_button.dart';

class RatingDropdown extends StatelessWidget {
  final double min;
  final double max;
  final void Function(double min, double max) onChange;
  const RatingDropdown(
      {super.key,
      required this.min,
      required this.max,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    final minRatings = List.generate(6, (i) => i.toDouble());
    final maxRatings = List.generate(5, (i) => (i + 6).toDouble());
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaddedText('Rating'),
        Row(children: [
          Expanded(
            child: OutlinedDropdownButton(
                items: minRatings,
                value: min,
                onChanged: (minimum) {
                  if (minimum == null) return;
                  onChange(minimum, max);
                },
                prefixText: 'Min'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedDropdownButton(
                items: maxRatings,
                value: 6.0,
                onChanged: (maximum) {
                  if (maximum == null) return;
                  onChange(min, maximum);
                },
                prefixText: 'Max'),
          ),
        ])
      ],
    );
  }
}
