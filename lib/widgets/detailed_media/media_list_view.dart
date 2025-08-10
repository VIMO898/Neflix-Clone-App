import 'package:app/widgets/detailed_media/media_card.dart';
import 'package:flutter/cupertino.dart';

import '../../models/media/media_image_model.dart';
import '../../models/media/media_video_model.dart';

class MediaListView extends StatelessWidget {
  final List<MediaVideoModel>? videos;
  final List<MediaImageModel>? images;
  final int maxMediaItemToDisplay;
  final VoidCallback onMore;

  const MediaListView.videos({
    super.key,
    this.maxMediaItemToDisplay = 5,
    required this.videos,
    required this.onMore,
  }) : images = null;
  const MediaListView.images({
    super.key,
    this.maxMediaItemToDisplay = 5,
    required this.images,
    required this.onMore,
  }) : videos = null;

  @override
  Widget build(BuildContext context) {
    final isVideoList = videos != null;
    final mediaLength = isVideoList
        ? videos!.take(maxMediaItemToDisplay).length
        : images!.take(maxMediaItemToDisplay).length;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mediaLength + (mediaLength >= maxMediaItemToDisplay ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == mediaLength) {
            return GestureDetector(
              onTap: onMore,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 18),
                child: Icon(
                  CupertinoIcons.arrow_right_circle,
                  size: 50,
                ),
              ),
            );
          }

          return isVideoList
              ? MediaCard.video(video: videos![index])
              : MediaCard.image(image: images![index]);
          // return Placeholder();
        });
  }
}
