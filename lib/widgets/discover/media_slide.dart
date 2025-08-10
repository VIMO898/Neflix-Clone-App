import 'package:app/constants/enums.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/widgets/discover/skeletons/media_slide_skeleton.dart';
import 'package:app/widgets/general/placeholder_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/general/movie_genres_provider.dart';
import '../../screens/detailed_media_screen.dart';
import '../../utils/genre_ids_to_names.dart';
import '../../utils/navigator_shortcuts.dart';

class MediaSlide extends ConsumerWidget {
  final ExploreMediaType? type;
  final Object? mediaOverview;
  final bool isLoading;
  const MediaSlide({
    super.key,
    this.isLoading = false,
    required this.type,
    required this.mediaOverview,
  });

  @override
  Widget build(BuildContext context, ref) {
    if (isLoading) return MediaSlideSkeleton();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final movieGenres = ref.watch(movieGenresProvider);
    final tvGenres = ref.watch(movieGenresProvider);
    late String? backdropPath;
    late String title;
    late double voteAverage;
    late String genreNames;
    late String releaseDate;
    // setting media-type-specific properties accordingly
    switch (type!) {
      case ExploreMediaType.movies:
        final movieOverview = mediaOverview as MovieOverviewModel;
        title = movieOverview.title;
        genreNames = genreIdsToNames(movieGenres, movieOverview.genreIds);
        backdropPath = movieOverview.backdropPath != null
            ? 'https://image.tmdb.org/t/p/w780/${movieOverview.backdropPath!}'
            : null;
        voteAverage = movieOverview.voteAverage;
        releaseDate = movieOverview.releaseDate;
      case ExploreMediaType.tvShows:
        final tvShowOverview = mediaOverview as TvShowOverviewModel;
        title = tvShowOverview.name;
        genreNames = genreIdsToNames(tvGenres, tvShowOverview.genreIds);
        backdropPath = tvShowOverview.backdropPath != null
            ? 'https://image.tmdb.org/t/p/w780/${tvShowOverview.backdropPath!}'
            : null;
        voteAverage = tvShowOverview.voteAverage;
        releaseDate = tvShowOverview.firstAirDate;
    }

    void handleNavigationToDetailedMediaScreen() {
      NavHelper.push(
        context,
        DetailedMediaScreen(
          mediaType: type!,
          mediaId: (mediaOverview as dynamic).id,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: handleNavigationToDetailedMediaScreen,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CachedNetworkImageProvider(backdropPath!),
              onError: (exception, stackTrace) => PlaceholderImage(),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                genreNames,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              Text(
                '⭐ ${voteAverage.toStringAsFixed(1)} • $releaseDate',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
