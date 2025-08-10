import 'package:app/constants/enums.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../general/outlined_label.dart';

class ImageTypeHorizontalListView extends StatelessWidget {
  final Map<MediaImageType, int> availableImageTypes;
  final MediaImageType? selectedImageType;
  final void Function(MediaImageType imageType) onUpdatedType;
  const ImageTypeHorizontalListView({
    super.key,
    required this.availableImageTypes,
    required this.selectedImageType,
    required this.onUpdatedType,
  });

  @override
  Widget build(BuildContext context) {
    final availableVideoTypeEntries = availableImageTypes.entries.toList();
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableImageTypes.length,
        itemBuilder: (context, index) {
          final typeEntry = availableVideoTypeEntries[index];
          return OutlinedLabel(
            typeEntry.key.name.readable(),
            margin: const EdgeInsets.only(right: 12),
            number: typeEntry.value,
            selected: selectedImageType == typeEntry.key,
            onTap: () => onUpdatedType(typeEntry.key),
          );
        },
      ),
    );
  }
}
