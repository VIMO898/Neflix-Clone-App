import 'package:app/widgets/general/placeholder_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaHeadingContent extends StatelessWidget {
  final String title;
  final List<String> highlights;
  final String? imgUrl;
  final int voteCount;
  final double voteAverage;
  final bool smallerTitle;
  const MediaHeadingContent({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.highlights,
    required this.voteCount,
    required this.voteAverage,
    this.smallerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textBodyLarge = textTheme.bodyMedium?.copyWith(
      color: colorScheme.secondary,
      // fontSize: 18,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMediaProfilePic(imgUrl),
        _buildNameText(title, textTheme, colorScheme),
        Text(highlights.join(' • '), style: textBodyLarge),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
              const SizedBox(width: 3),
              Text(
                '${voteAverage.toStringAsFixed(1)}/10',
                style: textBodyLarge!.copyWith(
                  letterSpacing: 0.2,
                  fontSize: textBodyLarge.fontSize! + 2,
                ),
              ),
              const SizedBox(width: 6),
              Text('($voteCount votes)'),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildNameText(
    String name,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        name,
        style: textTheme.headlineMedium!.copyWith(
          // fontSize: smallerTitle ? 26 : null,
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox _buildMediaProfilePic(String? networkImgSrc) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: networkImgSrc == null
          ? PlaceholderImage()
          : CachedNetworkImage(
              imageUrl: networkImgSrc,
              fit: BoxFit.cover,
              placeholder: (context, url) => PlaceholderImage(),
              errorWidget: (context, url, error) => PlaceholderImage(),
            ),
    );
  }
}
