import 'package:app/constants/enums.dart';
import 'package:app/controllers/hive_media_controller.dart';
import 'package:app/providers/controllers/liked_media_controller_provider.dart';
import 'package:app/providers/controllers/already_watched_media_controller_provider.dart';
import 'package:app/providers/controllers/media_watch_list_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'circle_icon_with_label.dart';

class MediaActionButtons extends ConsumerWidget {
  final dynamic mediaOverview;
  final ExploreMediaType mediaType;
  final int mediaId;
  final EdgeInsets padding;
  const MediaActionButtons({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.mediaOverview,
    this.padding = const EdgeInsets.symmetric(horizontal: 18),
  });

  void _handleMediaToggle({
    required HiveMediaController notifier,
    required bool isSelected,
  }) {
    if (mediaType == ExploreMediaType.movies) {
      !isSelected
          ? notifier.addMovie(mediaOverview)
          : notifier.removeMovie(mediaId);
    } else {
      !isSelected
          ? notifier.addTvShow(mediaOverview)
          : notifier.removeTvShow(mediaId);
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final watchlist = ref.watch(mediaWatchListControllerProvider);
    final alreadyWatched = ref.watch(alreadyWatchedMediaControllerProvider);
    final likedMedia = ref.watch(likedMediaControllerProvider);

    late bool isMediaLiked;
    late bool isMediaWatchList;
    late bool isMediaAlreadyWatched;
    switch (mediaType) {
      case ExploreMediaType.movies:
        isMediaLiked = likedMedia.movies.any((m) => m.id == mediaId);
        isMediaWatchList = watchlist.movies.any((m) => m.id == mediaId);
        isMediaAlreadyWatched = alreadyWatched.movies.any(
          (m) => m.id == mediaId,
        );
      case ExploreMediaType.tvShows:
        isMediaLiked = likedMedia.tvShows.any((t) => t.id == mediaId);
        isMediaWatchList = watchlist.tvShows.any((t) => t.id == mediaId);
        isMediaAlreadyWatched = alreadyWatched.tvShows.any(
          (t) => t.id == mediaId,
        );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: padding,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconWithLabel(
            selected: isMediaLiked,
            icon: FontAwesomeIcons.heart,
            label: 'Like',
            selectedLabel: 'Liked',
            selectedIcon: FontAwesomeIcons.solidHeart,
            onPressed: (_) => _handleMediaToggle(
              notifier: ref.read(likedMediaControllerProvider.notifier),
              isSelected: isMediaLiked,
            ),
          ),
          CircleIconWithLabel(
            selected: isMediaWatchList,
            icon: FontAwesomeIcons.clock,
            label: 'WatchList',
            selectedIcon: FontAwesomeIcons.solidClock,
            onPressed: (_) => _handleMediaToggle(
              notifier: ref.read(mediaWatchListControllerProvider.notifier),
              isSelected: isMediaWatchList,
            ),
          ),
          // if (onCollection != null)
          //   CircleIconWithLabel(
          //       icon: Icons.library_add_outlined,
          //       label: 'Collection',
          //       onPressed: (_) {}),
          CircleIconWithLabel(
            selected: isMediaAlreadyWatched,
            icon: FontAwesomeIcons.eye,
            label: 'Watched',
            selectedIcon: FontAwesomeIcons.solidEye,
            onPressed: (_) => _handleMediaToggle(
              notifier: ref.read(
                alreadyWatchedMediaControllerProvider.notifier,
              ),
              isSelected: isMediaAlreadyWatched,
            ),
          ),
        ],
      ),
    );
  }
}
