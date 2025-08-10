import 'package:app/widgets/general/placeholder_image.dart';
import 'package:app/widgets/general/skeletons/media_tile_skeleton.dart';
import 'package:flutter/material.dart';

class MediaTile extends StatelessWidget {
  final bool isLoading;
  final String? imgSrc;
  final String? title;
  final String? subtitle;
  final String? genres;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  const MediaTile({
    super.key,
    this.isLoading = false,
    required this.imgSrc,
    required this.title,
    required this.subtitle,
    required this.genres,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.colorScheme.primary;
    final dividerStyles = BorderSide(width: 0.5, color: Colors.grey);
    final bodyLargeStyle = textTheme.bodyMedium?.copyWith(
      color: primaryColor,
      // fontSize: 17.5,
    );
    return isLoading
        ? MediaTileSkeleton()
        : InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(border: Border(bottom: dividerStyles)),
              child: Row(
                children: [
                  imgSrc == null
                      ? PlaceholderImage(width: 70, height: 100)
                      : Image.network(
                          imgSrc!,
                          width: 70,
                          height: 100,
                          fit: BoxFit.cover,
                          // loadingBuilder: (context, child, loadingProgress) {
                          //   return  Center(child: CircularProgressIndicator());
                          // },
                          errorBuilder: (context, error, stackTrace) {
                            return PlaceholderImage(width: 70, height: 100);
                          },
                        ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFlexibleText(
                          title!,
                          maxLines: 2,
                          style: textTheme.titleMedium?.copyWith(
                            // fontSize: 19,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (genres != null && genres!.isNotEmpty)
                          _buildFlexibleText(genres!, style: bodyLargeStyle),
                        if (subtitle != null && subtitle!.isNotEmpty)
                          _buildFlexibleText(subtitle!, style: bodyLargeStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildFlexibleText(
    String text, {
    TextStyle? style,
    int maxLines = 1,
  }) => Text(
    text,
    style: style,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
  );
}
