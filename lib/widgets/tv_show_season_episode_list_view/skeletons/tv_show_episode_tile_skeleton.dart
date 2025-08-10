import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TvShowEpisodeTileSkeleton extends StatelessWidget {
  const TvShowEpisodeTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final dividerStyles = BorderSide(width: 0.5, color: Colors.grey);
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(border: Border(bottom: dividerStyles)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (S01E01 Episode Name)
            Container(
              width: 180,
              height: textTheme.titleMedium?.fontSize ?? 18,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            // Air date and runtime
            Container(
              width: 120,
              height: textTheme.bodySmall?.fontSize ?? 14,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            // Overview (3 lines)
            ...List.generate(
              3,
              (i) => Container(
                width: double.infinity,
                height: textTheme.bodySmall?.fontSize ?? 14,
                color: Colors.white,
                margin: EdgeInsets.only(bottom: i == 2 ? 0 : 6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
