import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../models/media/media_image_model.dart';
import '../../models/media/media_video_model.dart';
import '../../screens/youtube_video_player_screen.dart';
import '../../utils/navigator_shortcuts.dart';
import '../general/placeholder_image.dart';

class MediaCard extends StatelessWidget {
  final MediaVideoModel? video;
  final MediaImageModel? image;
  const MediaCard.video({
    super.key,
    required this.video,
  }) : image = null;
  const MediaCard.image({
    super.key,
    required this.image,
  }) : video = null;

  void _handleCardTap(BuildContext context) {
    if (video != null) {
      NavHelper.push(context,
          YoutubeVideoPlayerScreen(title: video!.name, youtubeUrl: video!.key));
    } else {
      _showImage(context);
    }
  }

  void _showImage(BuildContext context) {
    final imageProvider =
        Image.network('https://image.tmdb.org/t/p/w500/${image!.filePath}')
            .image;

    showImageViewer(
      context,
      imageProvider,
      swipeDismissible: true,
      doubleTapZoomable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final mediaImgPath = video != null
        ? 'https://img.youtube.com/vi/${video!.key}/hqdefault.jpg'
        : 'https://image.tmdb.org/t/p/w500/${image!.filePath}';
    return GestureDetector(
      onTap: () => _handleCardTap(context),
      child: Container(
        // width: 160,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.only(right: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                  imageUrl: mediaImgPath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => PlaceholderImage(),
                  errorWidget: (context, error, stackTrace) =>
                      PlaceholderImage()),
            ),
            if (video != null)
              IconButton(
                  onPressed: () => _handleCardTap(context),
                  icon: Icon(Icons.play_circle_filled, size: 38)),
            if (video != null)
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.black.withValues(alpha: 0.4),
                      child: Text(
                        video!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge
                            ?.copyWith(height: 1.2, color: Colors.white),
                      ))),
          ],
        ),
      ),
    );
  }
}
