import 'package:app/screens/media_gallery_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:flutter/material.dart';

import '../../models/media/categorized_media_image_model.dart';
import '../../models/media/media_video_model.dart';
import 'media_list_view.dart';

class MediaVideosAndPhotos extends StatelessWidget {
  final List<MediaVideoModel> videos;
  final CategorizedMediaImageModel categorizedImages;
  const MediaVideosAndPhotos(
      {super.key, required this.videos, required this.categorizedImages});

  void _handleOpenMediaGalleryScreen(BuildContext context) {
    NavHelper.push(
        context,
        MediaGalleryScreen.availableData(
            categorizedMediaImages: categorizedImages, mediaVideos: videos));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return DefaultTabController(
      initialIndex: 0,
      length:
          videos.isNotEmpty && categorizedImages.backdrops.isNotEmpty ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 40,
            child: TabBar(
                dividerHeight: 0,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: textTheme.titleLarge
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                tabs: [
                  if (videos.isNotEmpty)
                    Tab(
                      text: 'Videos',
                    ),
                  if (categorizedImages.backdrops.isNotEmpty)
                    Tab(
                      text: 'Photos',
                    )
                ]),
          ),
          SizedBox(
            height: 160,
            child: TabBarView(children: [
              if (videos.isNotEmpty)
                MediaListView.videos(
                    videos: videos,
                    onMore: () => _handleOpenMediaGalleryScreen(context)),
              if (categorizedImages.backdrops.isNotEmpty)
                MediaListView.images(
                    images: categorizedImages.backdrops,
                    onMore: () => _handleOpenMediaGalleryScreen(context)),
            ]),
          )
        ]),
      ),
    );
  }
}
