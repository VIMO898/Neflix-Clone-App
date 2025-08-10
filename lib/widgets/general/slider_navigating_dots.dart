import 'package:app/widgets/general/skeletons/slider_navigating_dots_skeleton.dart';
import 'package:flutter/material.dart';

class SliderNavigatingDots extends StatelessWidget {
  const SliderNavigatingDots({
    super.key,
    this.isLoading = false,
    required this.totalPages,
    required this.currPageIndex,
    required this.onDotTap,
  });
  final bool isLoading;
  final int? totalPages;
  final int? currPageIndex;
  final void Function(int updatedIndex) onDotTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    return isLoading
        ? SliderNavigatingDotsSkeleton()
        : Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages!,
                (index) => GestureDetector(
                  onTap: () => onDotTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: currPageIndex == index ? 20 : 12,
                    height: 10,
                    decoration: BoxDecoration(
                      color: currPageIndex == index
                          ? primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
