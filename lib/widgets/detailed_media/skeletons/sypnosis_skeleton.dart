import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:app/widgets/general/skeletons/expandable_text_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SypnosisSkeleton extends StatelessWidget {
  const SypnosisSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    final baseColor = shimmerColors.baseColor;
    final highlightColor = shimmerColors.highlightColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // heading text
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 14),
            width: 90,
            height: textTheme.titleLarge?.fontSize ?? 20,
          ),
        ),
        ExpandableTextSkeleton(
          padding: const EdgeInsets.only(bottom: 25),
          maxLines: 4,
        ),
      ],
    );
  }
}
