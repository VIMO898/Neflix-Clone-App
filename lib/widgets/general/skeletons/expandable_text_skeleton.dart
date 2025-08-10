import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExpandableTextSkeleton extends StatelessWidget {
  final int maxLines;
  final EdgeInsets padding;
  const ExpandableTextSkeleton({
    super.key,
    this.maxLines = 3,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final lineHeight = (textTheme.bodyMedium?.fontSize ?? 14) * 1.4;
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    return Padding(
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: shimmerColors.baseColor,
        highlightColor: shimmerColors.highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton lines for text
            ...List.generate(
              maxLines,
              (i) => Container(
                width: double.infinity,
                height: lineHeight,
                color: Colors.white,
                margin: EdgeInsets.only(bottom: i == maxLines - 1 ? 0 : 8),
              ),
            ),
            const SizedBox(height: 8),
            // Skeleton for "Read More"/"Read Less" button
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 60,
                height: textTheme.bodySmall?.fontSize ?? 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
