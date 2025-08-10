import 'package:app/widgets/detailed_media/skeletons/circle_icon_with_label_skeleton.dart';
import 'package:flutter/material.dart';

class MediaActionButtonsSkeleton extends StatelessWidget {
  final EdgeInsets padding;
  const MediaActionButtonsSkeleton({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 26),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: padding,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconWithLabelSkeleton(),
          CircleIconWithLabelSkeleton(),
          CircleIconWithLabelSkeleton(),
        ],
      ),
    );
  }
}
