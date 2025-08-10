import 'package:app/widgets/general/media_card.dart';
import 'package:flutter/material.dart';

class MediaGridView extends StatelessWidget {
  final int itemCount;
  final MediaCard Function(BuildContext context, int index) itemBuilder;
  const MediaGridView(
      {super.key, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 6,
          mainAxisExtent: 190),
      itemCount: itemCount,
      padding: const EdgeInsets.all(8),
      itemBuilder: itemBuilder,
    );
  }
}
