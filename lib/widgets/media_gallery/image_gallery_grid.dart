import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/media/media_image_model.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/utils/tmdb_image_url.dart';
import 'package:app/widgets/general/placeholder_image.dart';
import 'package:app/widgets/media_gallery/image_type_horizontal_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/media/categorized_media_image_model.dart';
import '../general/centered_message.dart';

class ImageGalleryGrid extends ConsumerStatefulWidget {
  final int? mediaId;
  final ExploreMediaType? mediaType;
  final CategorizedMediaImageModel? images;
  // network call with media type & id
  const ImageGalleryGrid.loadData({
    super.key,
    required this.mediaId,
    required this.mediaType,
  }) : images = null;
  // available image data
  const ImageGalleryGrid.availableData({super.key, required this.images})
    : mediaId = null,
      mediaType = null;

  @override
  ConsumerState<ImageGalleryGrid> createState() => _ImageGalleryGridState();
}

class _ImageGalleryGridState extends ConsumerState<ImageGalleryGrid> {
  MediaImageType _selectedImageType = MediaImageType.backdrop;
  Future<CategorizedMediaImageModel>? _getMediaImageFuture;

  @override
  void initState() {
    super.initState();
    if (widget.images == null) {
      final repo = ref.read(tmdbRepoProvider);
      _getMediaImageFuture = repo.getMediaImages(
        type: widget.mediaType!,
        id: widget.mediaId!,
      );
    }
  }

  void _handleSelectImageType(MediaImageType updatedType) {
    _selectedImageType = updatedType;
    setState(() {});
  }

  void _showImage(
    BuildContext context, {
    required List<MediaImageModel> images,
    required int startAtIndex,
  }) {
    final imageProviders = images
        .map(
          (img) => Image.network(
            'https://image.tmdb.org/t/p/original/${img.filePath}',
          ).image,
        )
        .toList();

    final multiImageProvider = MultiImageProvider(
      imageProviders,
      initialIndex: startAtIndex,
    );

    showImageViewerPager(
      context,
      multiImageProvider,
      immersive: true,
      useSafeArea: true,
      swipeDismissible: true,
      doubleTapZoomable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.images == null
        ? FutureBuilder(
            future: _getMediaImageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                final error = snapshot.error;
                log(error.toString());
                if (error is TmdbException) {
                  return CenteredMessage(
                    iconColor: Colors.redAccent,
                    title: error.statusCode != null
                        ? error.statusCode!.toString()
                        : '404',
                    subtitle:
                        error.statusMessage ??
                        'Something went wrong, please check your internet connection status',
                  );
                }
                return CenteredMessage(
                  iconColor: Colors.redAccent,
                  title: '404',
                  subtitle:
                      'Something went wrong, please check your internet connection status',
                );
              }
              final data = snapshot.data!;
              return _buildImageGrid(data);
            },
          )
        : _buildImageGrid(widget.images!);
  }

  Widget _buildImageGrid(CategorizedMediaImageModel categorizedImages) {
    final backdrops = categorizedImages.backdrops
        .map(
          (b) => b.copyWith(
            filePath: getTmdbImageUrl(
              type: ImageType.backdrop,
              size: ImageSize.w780,
              filePath: b.filePath,
            ),
          ),
        )
        .toList();
    final posters = categorizedImages.posters
        .map(
          (p) => p.copyWith(
            filePath: getTmdbImageUrl(
              type: ImageType.poster,
              size: ImageSize.w300,
              filePath: p.filePath,
            ),
          ),
        )
        .toList();
    final logos = categorizedImages.logos
        .map(
          (l) => l.copyWith(
            filePath: getTmdbImageUrl(
              type: ImageType.logo,
              size: ImageSize.w185,
              filePath: l.filePath,
            ),
          ),
        )
        .toList();
    Map<MediaImageType, List<MediaImageModel>> allTypeImages = {
      MediaImageType.backdrop: backdrops,
      MediaImageType.poster: posters,
      MediaImageType.logo: logos,
    };
    final eachImageTypeNumberCount = allTypeImages.map(
      (imgType, images) => MapEntry(imgType, images.length),
    );
    final selectedTypeImages = allTypeImages[_selectedImageType]!;
    return Column(
      children: [
        ImageTypeHorizontalListView(
          availableImageTypes: eachImageTypeNumberCount,
          selectedImageType: _selectedImageType,
          onUpdatedType: _handleSelectImageType,
          // onShowAllTypes: _handleShowAllImages,
        ),
        Expanded(
          child: MasonryGridView.builder(
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(12),
            itemCount: selectedTypeImages.length,
            itemBuilder: (context, index) {
              final currImage = (selectedTypeImages)[index];
              return InkWell(
                onTap: () => _showImage(
                  context,
                  images: selectedTypeImages,
                  startAtIndex: index,
                ),
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: currImage.filePath,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => PlaceholderImage(),
                    errorWidget: (context, error, stackTrace) =>
                        PlaceholderImage(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
