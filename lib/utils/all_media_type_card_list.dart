import 'package:app/utils/tmdb_image_url.dart';
import 'package:app/widgets/general/media_card.dart';
import 'package:app/widgets/general/media_overview_dialog.dart';
import 'package:app/widgets/general/person_overview_dialog.dart';
import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../models/movies/movie_overview_model.dart';
import '../models/people/person_model.dart';
import '../models/shows/tv_show_overview_model.dart';
import '../screens/detailed_media_screen.dart';
import '../screens/person_profile_screen.dart';
import 'navigator_shortcuts.dart';

List<MediaCard> allMediaTypeCardList(
  BuildContext context, {
  EdgeInsets cardMargin = EdgeInsets.zero,
  Size? cardSize,
  bool isLoading = false,
  required AllMediaType type,
  required List<Object>? mediaList,
  void Function(Object media)? onMediaCardTap,
}) {
  void handleMediaCardTap(dynamic media) {
    if (onMediaCardTap != null) onMediaCardTap(media);
    switch (type) {
      case AllMediaType.movies:
        NavHelper.push(
          context,
          DetailedMediaScreen(
            mediaType: ExploreMediaType.movies,
            mediaId: media.id,
          ),
        );
      case AllMediaType.tvShows:
        NavHelper.push(
          context,
          DetailedMediaScreen(
            mediaType: ExploreMediaType.tvShows,
            mediaId: media.id,
          ),
        );
      case AllMediaType.people:
        NavHelper.push(context, PersonProfileScreen(personId: media.id));
    }
  }

  void handleMediaCardLongPress(dynamic media) {
    switch (type) {
      case AllMediaType.movies:
        showDialog(
          context: context,
          builder: (context) => MediaOverviewDialog(
            type: ExploreMediaType.movies,
            mediaOverview: media,
            onMore: () {
              NavHelper.pushReplacement(
                context,
                DetailedMediaScreen(
                  mediaType: ExploreMediaType.movies,
                  mediaId: media.id,
                ),
              );
            },
          ),
        );
      case AllMediaType.tvShows:
        showDialog(
          context: context,
          builder: (context) => MediaOverviewDialog(
            type: ExploreMediaType.tvShows,
            mediaOverview: media,
            onMore: () {
              NavHelper.pushReplacement(
                context,
                DetailedMediaScreen(
                  mediaType: ExploreMediaType.tvShows,
                  mediaId: media.id,
                ),
              );
            },
          ),
        );
      case AllMediaType.people:
        showDialog(
          context: context,
          builder: (context) => PersonOverviewDialog(personInfo: media),
        );
    }
  }

  return switch (type) {
    AllMediaType.movies => List.generate(isLoading ? 20 : mediaList!.length, (
      index,
    ) {
      final m = !isLoading
          ? (mediaList as List<MovieOverviewModel>)[index]
          : null;
      return MediaCard(
        margin: cardMargin,
        isLoading: isLoading,
        size: cardSize,
        title: m?.title,
        subtitle: m?.releaseDate.split('-').first,
        imgSrc: getTmdbImageUrl(
          type: ImageType.poster,
          size: ImageSize.w342,
          filePath: m?.posterPath ?? '',
        ),
        onTap: () => handleMediaCardTap(m),
        onLongPress: () => handleMediaCardLongPress(m),
      );
    }),
    AllMediaType.tvShows => List.generate(isLoading ? 20 : mediaList!.length, (
      index,
    ) {
      final tv = !isLoading
          ? (mediaList as List<TvShowOverviewModel>)[index]
          : null;
      return MediaCard(
        margin: cardMargin,
        size: cardSize,
        isLoading: isLoading,
        title: tv?.name,
        subtitle: tv?.firstAirDate.split('-').first,
        imgSrc: getTmdbImageUrl(
          type: ImageType.poster,
          size: ImageSize.w342,
          filePath: tv?.posterPath ?? '',
        ),
        onTap: () => handleMediaCardTap(tv),
        onLongPress: () => handleMediaCardLongPress(tv),
      );
    }),
    AllMediaType.people => List.generate(isLoading ? 20 : mediaList!.length, (
      index,
    ) {
      final p = !isLoading ? (mediaList as List<PersonModel>)[index] : null;
      return MediaCard(
        margin: cardMargin,
        size: cardSize,
        isLoading: isLoading,
        imgSrc: getTmdbImageUrl(
          type: ImageType.profile,
          size: ImageSize.w185,
          filePath: p?.profilePath ?? '',
        ),
        title: p?.name,
        subtitle: '⭐ ${p?.popularity.toStringAsFixed(1)}',
        onTap: () => handleMediaCardTap(p),
        onLongPress: () => handleMediaCardLongPress(p),
      );
    }),
  };
}
