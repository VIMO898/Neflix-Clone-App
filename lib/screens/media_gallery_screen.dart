import 'package:app/constants/enums.dart';
import 'package:app/models/media/categorized_media_image_model.dart';
import 'package:app/widgets/media_gallery/image_gallery_grid.dart';
import 'package:app/widgets/media_gallery/video_list_view.dart';
import 'package:flutter/material.dart';

import '../models/media/media_video_model.dart';
import '../widgets/media_gallery/gallery_tab_bar.dart';

class MediaGalleryScreen extends StatelessWidget {
  final ExploreMediaType? type;
  final int? mediaId;
  final CategorizedMediaImageModel? categorizedMediaImages;
  final List<MediaVideoModel>? mediaVideos;
  const MediaGalleryScreen.loadData({
    super.key,
    required this.type,
    required this.mediaId,
  }) : categorizedMediaImages = null,
       mediaVideos = null;

  const MediaGalleryScreen.availableData({
    super.key,
    required this.categorizedMediaImages,
    required this.mediaVideos,
  }) : mediaId = null,
       type = null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          centerTitle: true,
          bottom: MediaGalleryTabBar(),
        ),
        body: TabBarView(
          children: categorizedMediaImages == null && mediaVideos == null
              ? [
                  VideoListView.loadData(mediaId: mediaId, mediaType: type),
                  ImageGalleryGrid.loadData(mediaId: mediaId, mediaType: type),
                ]
              : [
                  VideoListView.availableData(videos: mediaVideos),
                  ImageGalleryGrid.availableData(
                    images: categorizedMediaImages,
                  ),
                ],
        ),
      ),
    );
  }
}
