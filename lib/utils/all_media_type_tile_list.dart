import 'package:app/models/general/genre_model.dart';
import 'package:app/widgets/general/media_tile.dart';
import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../models/movies/movie_overview_model.dart';
import '../models/people/person_model.dart';
import '../models/shows/tv_show_overview_model.dart';
import '../screens/detailed_media_screen.dart';
import '../screens/person_profile_screen.dart';
import '../widgets/general/media_overview_dialog.dart';
import '../widgets/general/person_overview_dialog.dart';
import 'genre_ids_to_names.dart';
import 'navigator_shortcuts.dart';

List<MediaTile> allMediaTypeTileList(
  BuildContext context, {
  bool isLoading = false,
  required AllMediaType type,
  required List<Object>? mediaList,
  required List<GenreModel> movieGenres,
  required List<GenreModel> tvShowGenres,
  void Function(Object media)? onMediaTileTap,
}) {
  void handleMediaTileTap(dynamic media) {
    if (onMediaTileTap != null) onMediaTileTap(media);
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
      return MediaTile(
        isLoading: isLoading,
        imgSrc: m?.posterPath != null
            ? 'https://image.tmdb.org/t/p/w185/${m!.posterPath}'
            : null,
        title: m?.title,
        subtitle: m?.releaseDate,
        genres: !isLoading ? genreIdsToNames(movieGenres, m!.genreIds) : null,
        onTap: () => handleMediaTileTap(m),
        onLongPress: () => handleMediaCardLongPress(m),
      );
    }),
    AllMediaType.tvShows => List.generate(isLoading ? 20 : mediaList!.length, (
      index,
    ) {
      final tv = !isLoading
          ? (mediaList as List<TvShowOverviewModel>)[index]
          : null;
      return MediaTile(
        isLoading: isLoading,
        imgSrc: tv?.posterPath != null
            ? 'https://image.tmdb.org/t/p/w185/${tv!.posterPath}'
            : null,
        title: tv?.name,
        subtitle: tv?.firstAirDate,
        genres: !isLoading ? genreIdsToNames(tvShowGenres, tv!.genreIds) : null,
        onTap: () => handleMediaTileTap(tv),
        onLongPress: () => handleMediaCardLongPress(tv),
      );
    }),
    AllMediaType.people => List.generate(isLoading ? 20 : mediaList!.length, (
      index,
    ) {
      final p = !isLoading ? (mediaList as List<PersonModel>)[index] : null;
      return MediaTile(
        isLoading: isLoading,
        imgSrc: p?.profilePath != null
            ? 'https://image.tmdb.org/t/p/w185/${p!.profilePath}'
            : null,
        title: p?.name,
        subtitle: !isLoading ? '⭐ ${p!.popularity.toStringAsFixed(1)}' : null,
        genres: p?.knownForDepartment,
        onTap: () => handleMediaTileTap(p),
        onLongPress: () => handleMediaCardLongPress(p),
      );
    }),
  };
}
