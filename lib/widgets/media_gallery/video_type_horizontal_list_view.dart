import 'package:app/constants/enums.dart';
import 'package:app/constants/map_constants.dart';
import 'package:flutter/material.dart';

import '../general/outlined_label.dart';

class VideoTypeHorizontalListView extends StatelessWidget {
  final Map<MediaVideoType, int> availableVideoTypes;
  final MediaVideoType? selectedVideoType;
  final void Function(MediaVideoType videoType) onUpdatedType;
  final VoidCallback onShowAllTypes;
  const VideoTypeHorizontalListView({
    super.key,
    required this.availableVideoTypes,
    required this.selectedVideoType,
    required this.onUpdatedType,
    required this.onShowAllTypes,
  });

  @override
  Widget build(BuildContext context) {
    final availableVideoTypeEntries = availableVideoTypes.entries.toList();
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableVideoTypes.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return OutlinedLabel(
              'All',
              margin: const EdgeInsets.only(right: 12),
              selected: selectedVideoType == null,
              onTap: onShowAllTypes,
            );
          }
          final typeEntry = availableVideoTypeEntries[index - 1];
          return OutlinedLabel(
            mediaVideoTypeToString[typeEntry.key] ?? '',
            margin: const EdgeInsets.only(right: 12),
            number: typeEntry.value,
            selected: selectedVideoType == typeEntry.key,
            onTap: () => onUpdatedType(typeEntry.key),
          );
        },
      ),
    );
  }
}
