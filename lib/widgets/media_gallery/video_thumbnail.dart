import 'package:app/widgets/general/placeholder_image.dart';
import 'package:flutter/material.dart';

class VideThumbnail extends StatelessWidget {
  final String videoId;
  const VideThumbnail({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.8),
              errorBuilder: (context, error, stackTrace) => PlaceholderImage(),
            ),
          ),
          Icon(Icons.play_circle, size: 50),
        ],
      ),
    );
  }
}
