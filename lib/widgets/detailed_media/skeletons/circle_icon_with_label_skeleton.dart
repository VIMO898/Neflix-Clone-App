import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircleIconWithLabelSkeleton extends StatelessWidget {
  final double iconSize;
  final double circleRadius;
  const CircleIconWithLabelSkeleton({
    super.key,
    this.iconSize = 25.0,
    this.circleRadius = 55.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circle icon skeleton
          Container(
            width: circleRadius,
            height: circleRadius,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          // Label skeleton
          Container(
            width: 50,
            height: textTheme.bodySmall?.fontSize ?? 12,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
