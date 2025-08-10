import 'package:flutter/material.dart';

import '../general/padded_text.dart';
import '../general/primary_drop_down_button.dart';

class RuntimeDropdown extends StatelessWidget {
  final ({List<int> min, List<int> max}) runtimeRange;
  final int min;
  final int max;
  final void Function(int min, int max) onChange;
  const RuntimeDropdown(
      {super.key,
      required this.runtimeRange,
      required this.min,
      required this.max,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaddedText('Runtime'),
        Row(children: [
          Expanded(
            child: OutlinedDropdownButton<int>(
              items: runtimeRange.min,
              value: min,
              prefixText: 'Min',
              onChanged: (_) {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedDropdownButton<int>(
              items: runtimeRange.max,
              value: max,
              onChanged: (maximum) {
                if (maximum == null) return;
                onChange(min, maximum);
              },
              prefixText: 'Max',
            ),
          ),
        ]),
      ],
    );
  }
}
