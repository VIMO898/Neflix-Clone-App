import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediaHeadingContentSkeleton extends StatelessWidget {
  const MediaHeadingContentSkeleton({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(width: double.infinity, height: 250, color: Colors.white),
          // Title skeleton
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 8),
            child: Container(
              width: 220,
              height: textTheme.headlineMedium?.fontSize ?? 28,
              color: Colors.white,
            ),
          ),
          // Highlights skeleton
          Container(
            width: 160,
            height: textTheme.bodyMedium?.fontSize ?? 18,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
          ),
          // Ratings row skeleton
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 50,
                  height: textTheme.bodyMedium?.fontSize ?? 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Container(
                  width: 60,
                  height: textTheme.bodyMedium?.fontSize ?? 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
