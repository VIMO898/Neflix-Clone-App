import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../general/padded_text.dart';
import '../general/primary_drop_down_button.dart';

class SortDropdown extends StatelessWidget {
  final SortBy sortBy;
  final SortOrder sortOrder;
  final void Function(SortBy sortBy, SortOrder sortOrder) onChange;
  const SortDropdown(
      {super.key,
      required this.sortBy,
      required this.sortOrder,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaddedText('Sort By'),
          Row(children: [
            Expanded(
              child: OutlinedDropdownButton<String>(
                  items: List.generate(SortBy.values.length, (i) {
                    return SortBy.values[i].name.readable();
                  }),
                  value: sortBy.name.readable(),
                  onChanged: (sortByStr) {
                    if (sortByStr == null) return;
                    log(sortByStr);
                    final updatedSortBy = SortBy.values
                        .firstWhere((s) => s.name.readable() == sortByStr);
                    onChange(updatedSortBy, sortOrder);
                  }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedDropdownButton(
                  items: List.generate(SortOrder.values.length, (i) {
                    return SortOrder.values[i].name.readable();
                  }),
                  value: sortOrder.name.readable(),
                  onChanged: (sortOrderStr) {
                    if (sortOrderStr == null) return;
                    final updatedSortOrder = SortOrder.values
                        .firstWhere((s) => s.name.readable() == sortOrderStr);
                    onChange(sortBy, updatedSortOrder);
                  }),
            ),
          ])
        ]);
  }
}
