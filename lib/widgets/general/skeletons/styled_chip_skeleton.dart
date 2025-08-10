import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StyledChipSkeleton extends StatelessWidget {
  final EdgeInsets? margin;
  const StyledChipSkeleton({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: Container(
        margin: margin,
        width: 75,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
