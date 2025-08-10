import 'package:app/widgets/general/skeletons/styled_chip_skeleton.dart';
import 'package:flutter/material.dart';

class WrappedOutlinedGenresSkeleton extends StatelessWidget {
  const WrappedOutlinedGenresSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: List.generate(3, (index) {
          return StyledChipSkeleton(
            margin: index == 2
                ? EdgeInsets.zero
                : const EdgeInsets.only(right: 16),
          );
        }),
      ),
    );
  }
}
