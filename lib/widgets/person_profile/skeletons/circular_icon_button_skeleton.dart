import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircularIconButtonSkeleton extends StatelessWidget {
  final double radius;
  const CircularIconButtonSkeleton({super.key, this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    final shimmerColors = Theme.of(context).extension<ShimmerColorsModel>()!;
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: CircleAvatar(backgroundColor: Colors.white, radius: radius),
    );
  }
}
