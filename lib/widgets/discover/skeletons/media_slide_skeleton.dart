import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediaSlideSkeleton extends StatelessWidget {
  const MediaSlideSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    final baseColor = shimmerColors.baseColor;
    final highlightColor = shimmerColors.highlightColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: textTheme.headlineSmall?.fontSize != null
                    ? textTheme.headlineSmall!.fontSize! * 2.2
                    : 44,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8),
              ),
              Container(
                width: 120,
                height: textTheme.bodyLarge?.fontSize ?? 18,
                color: Colors.white,

                margin: const EdgeInsets.only(bottom: 6),
              ),
              Container(
                width: 100,
                height: textTheme.bodyMedium?.fontSize ?? 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
