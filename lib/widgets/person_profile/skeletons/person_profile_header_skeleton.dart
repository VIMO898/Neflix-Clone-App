import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:app/widgets/general/skeletons/styled_chip_skeleton.dart';
import 'package:app/widgets/person_profile/skeletons/person_social_media_handles_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PersonProfileHeaderSkeleton extends StatelessWidget {
  const PersonProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shimmerColors = theme.extension<ShimmerColorsModel>()!;
    final textTheme = theme.textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildImageSkeleton(shimmerColors),
        _personNameTextSkeleton(shimmerColors, textTheme),
        StyledChipSkeleton(margin: const EdgeInsets.symmetric(vertical: 12)),
        PersonSocialMediaHandlesSkeleton(),
      ],
    );
  }

  Widget _personNameTextSkeleton(
    ShimmerColorsModel shimmerColors,
    TextTheme textTheme,
  ) {
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: Container(
        width: 230,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 4),
        color: Colors.white,
        height: textTheme.headlineMedium?.fontSize,
      ),
    );
  }

  Widget _buildImageSkeleton(ShimmerColorsModel shimmerColors) {
    return Shimmer.fromColors(
      baseColor: shimmerColors.baseColor,
      highlightColor: shimmerColors.highlightColor,
      child: Container(
        width: 150,
        height: 220,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
