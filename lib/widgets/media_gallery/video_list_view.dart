import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/models/media/media_video_model.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/widgets/media_gallery/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exceptions/tmdb_exception.dart';
import '../general/centered_message.dart';
import 'video_type_horizontal_list_view.dart';

class VideoListView extends ConsumerStatefulWidget {
  final int? mediaId;
  final ExploreMediaType? mediaType;
  final List<MediaVideoModel>? videos;
  const VideoListView.loadData({
    super.key,
    required this.mediaId,
    required this.mediaType,
  }) : videos = null;
  const VideoListView.availableData({super.key, required this.videos})
    : mediaId = null,
      mediaType = null;

  @override
  ConsumerState<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends ConsumerState<VideoListView> {
  MediaVideoType? _selectedVideoType;
  Future<List<MediaVideoModel>>? _getMediaVideoFuture;

  @override
  void initState() {
    super.initState();
    if (widget.videos == null) {
      final repo = ref.read(tmdbRepoProvider);
      _getMediaVideoFuture = repo.getMediaVideos(
        type: widget.mediaType!,
        id: widget.mediaId!,
      );
    }
  }

  void _handleShowAllVidoes() {
    _selectedVideoType = null;
    setState(() {});
  }

  void _handleSelectVideoType(MediaVideoType updatedType) {
    _selectedVideoType = updatedType;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.videos == null
          ? FutureBuilder<List<MediaVideoModel>>(
              future: _getMediaVideoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  log(error.toString());
                  if (error is TmdbException) {
                    return CenteredMessage(
                      title: error.statusCode != null
                          ? error.statusCode!.toString()
                          : '404',
                      subtitle:
                          error.statusMessage ??
                          'Something went wrong, please check your internet connection status',
                      iconColor: Colors.redAccent,
                    );
                  }
                  return CenteredMessage(
                    title: '404',
                    subtitle:
                        'Something went wrong, please check your internet connection status',
                    iconColor: Colors.redAccent,
                  );
                }
                final data = snapshot.data;
                return _buildVideoListView(data ?? []);
              },
            )
          : _buildVideoListView(widget.videos!),
    );
  }

  Widget _buildVideoListView(List<MediaVideoModel> videos) {
    Map<MediaVideoType, int> videoTypes = {};
    for (var v in videos) {
      final typeExists = videoTypes.containsKey(v.type);
      if (typeExists) {
        final currTypeValue = videoTypes[v.type];
        videoTypes[v.type] = currTypeValue! + 1;
      } else {
        videoTypes.addAll({v.type: 1});
      }
    }
    final selectedTypeVideos = _selectedVideoType != null
        ? videos.where((v) => v.type == _selectedVideoType).toList()
        : null;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 18),
      itemCount: (selectedTypeVideos?.length ?? videos.length) + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return VideoTypeHorizontalListView(
            availableVideoTypes: videoTypes,
            selectedVideoType: _selectedVideoType,
            onUpdatedType: _handleSelectVideoType,
            onShowAllTypes: _handleShowAllVidoes,
          );
        }
        final currVideo = (selectedTypeVideos ?? videos)[index - 1];
        return VideoCard(video: currVideo);
      },
    );
  }
}
