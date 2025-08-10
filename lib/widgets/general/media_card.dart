import 'package:app/widgets/general/placeholder_image.dart';
import 'package:app/widgets/general/skeletons/media_card_skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final bool isLoading;
  final String? title;
  final String? imgSrc;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final int titleMaxLines;
  final int subtitleMaxLines;
  final Alignment titleAlignment;
  final Alignment subtitleAlignment;
  final Size? size;
  final double? imgBorderCircularRadius;
  final EdgeInsets margin;

  const MediaCard({
    super.key,
    this.isLoading = false,
    required this.title,
    this.onTap,
    this.onLongPress,
    this.imgSrc,
    this.subtitle,
    this.imgBorderCircularRadius,
    this.size,
    this.margin = EdgeInsets.zero,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleMaxLines = 1,
    this.subtitleMaxLines = 1,
    this.titleAlignment = Alignment.topLeft,
    this.subtitleAlignment = Alignment.bottomLeft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return isLoading
        ? _buildSkeleton()
        : GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              margin: margin,
              width: size?.width,
              height: size?.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: imgBorderCircularRadius == null
                          ? BorderRadius.zero
                          : BorderRadius.circular(imgBorderCircularRadius!),
                      child: imgSrc == null
                          ? PlaceholderImage()
                          : CachedNetworkImage(
                              imageUrl: imgSrc!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => PlaceholderImage(),
                              errorWidget: (context, url, error) =>
                                  PlaceholderImage(),
                            ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: titleAlignment,
                    child: Text(
                      title!,
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (subtitle != null)
                    Align(
                      alignment: subtitleAlignment,
                      child: Text(
                        subtitle!,
                        maxLines: subtitleMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall!.copyWith(
                          fontSize: subtitleFontSize,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
  }

  MediaCardSkeleton _buildSkeleton() => MediaCardSkeleton(
    margin: margin,
    size: size,
    imgBorderCircularRadius: imgBorderCircularRadius,
    showSubtitle: subtitle != null && subtitle!.isNotEmpty,
    subtitleAlignment: subtitleAlignment,
    subtitleFontSize: subtitleFontSize,
    titleAlignment: titleAlignment,
    titleFontSize: titleFontSize,
  );
}
