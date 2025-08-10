import 'package:flutter/material.dart';

import '../general/padded_text.dart';
import '../general/primary_drop_down_button.dart';

class YearDropdown extends StatelessWidget {
  final int from;
  final int to;
  final void Function(int from, int to) onChange;
  const YearDropdown({
    super.key,
    required this.from,
    required this.to,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final int currYear = DateTime.now().year;
    final int startYear = 1975;
    // 2015 - 2 - 1975 + 1 = 44
    final rawFromYears = List.generate(
      to - 2 - startYear + 1,
      (i) => startYear + i,
    );

    final fromYears = {
      ...rawFromYears,
      from, // ensures `from` is included without duplication
    }.toList()..sort();
    final toYears = List.generate(currYear - from, (i) => (from + 1) + i);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaddedText('Year'),
        Row(
          children: [
            Expanded(
              child: OutlinedDropdownButton(
                items: fromYears,
                value: from,
                onChanged: (fromYear) {
                  if (fromYear == null) return;
                  onChange(fromYear, to);
                },
                // hint: 'From: 1975',
                prefixText: 'From',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedDropdownButton(
                items: toYears,
                value: to,
                onChanged: (toYear) {
                  if (toYear == null) return;
                  onChange(from, toYear);
                },
                // hint: 'To: 1975',
                prefixText: 'To',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
