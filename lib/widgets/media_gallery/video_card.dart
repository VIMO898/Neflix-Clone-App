import 'package:app/constants/map_constants.dart';
import 'package:app/models/media/media_video_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../screens/youtube_video_player_screen.dart';
import '../../utils/navigator_shortcuts.dart';
import 'video_thumbnail.dart';

class VideoCard extends StatelessWidget {
  final MediaVideoModel video;
  const VideoCard({super.key, required this.video});

  void _handleVideoTap(BuildContext context) {
    NavHelper.push(
      context,
      YoutubeVideoPlayerScreen(title: video.name, youtubeUrl: video.key),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isOfficial = video.official;
    final typeAsStr = mediaVideoTypeToString[video.type];
    final formattedPublishedAt = intl.DateFormat.yMd().format(
      video.publishedAt,
    );

    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _handleVideoTap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: VideThumbnail(videoId: video.key)),
            Text(
              video.name,
              style: textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${isOfficial ? "Official • " : ""} $typeAsStr • $formattedPublishedAt',
              style: textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
