import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/controllers/theme_state_controller_provider.dart';

class MediaCardSkeleton extends ConsumerWidget {
  final Size? size;
  final double? imgBorderCircularRadius;
  final EdgeInsets margin;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Alignment titleAlignment;
  final Alignment subtitleAlignment;
  final bool showSubtitle;

  const MediaCardSkeleton({
    super.key,
    this.size,
    this.imgBorderCircularRadius,
    this.margin = EdgeInsets.zero,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleAlignment = Alignment.topLeft,
    this.subtitleAlignment = Alignment.bottomLeft,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode =
        ref.watch(themeStateControllerProvider).themeMode == ThemeMode.dark;
    final baseColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDarkMode
        ? Colors.grey.shade600
        : Colors.grey.shade100;
    return Container(
      margin: margin,
      width: size?.width,
      height: size?.height,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: imgBorderCircularRadius == null
                    ? BorderRadius.zero
                    : BorderRadius.circular(imgBorderCircularRadius!),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: titleAlignment,
              child: Container(
                width: 80,
                height: titleFontSize ?? textTheme.titleMedium?.fontSize ?? 16,
                color: Colors.white,
              ),
            ),

            if (showSubtitle)
              Container(
                margin: const EdgeInsets.only(top: 6),
                alignment: subtitleAlignment,
                child: Container(
                  width: 40,
                  height:
                      subtitleFontSize ?? textTheme.labelMedium?.fontSize ?? 12,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
