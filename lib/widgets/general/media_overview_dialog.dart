import 'package:app/constants/enums.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/providers/general/movie_genres_provider.dart';
import 'package:app/providers/general/tv_show_genres_provider.dart';
import 'package:app/utils/genre_ids_to_names.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/detailed_media/media_action_buttons.dart';
import 'package:app/widgets/general/placeholder_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaOverviewDialog extends ConsumerWidget {
  final ExploreMediaType type;
  final dynamic mediaOverview;
  final VoidCallback onMore;
  const MediaOverviewDialog({
    super.key,
    required this.type,
    required this.mediaOverview,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final String? backdropPath = mediaOverview.backdropPath != null
        ? "https://image.tmdb.org/t/p/w500${mediaOverview.backdropPath}"
        : null;
    final String overview = mediaOverview.overview;
    // final String officialLanguage = mediaOverview.originalLanguage;
    final rating = mediaOverview.voteAverage;
    final votes = mediaOverview.voteCount;

    final movieGenres = ref.read(movieGenresProvider);
    final tvShowGenres = ref.read(tvShowGenresProvider);

    late String title;
    late String genres;
    late String year;

    switch (type) {
      case ExploreMediaType.movies:
        final movieOverview = mediaOverview as MovieOverviewModel;
        title = movieOverview.title;
        genres = genreIdsToNames(movieGenres, movieOverview.genreIds);
        year = movieOverview.releaseDate.split('-').first;
      case ExploreMediaType.tvShows:
        final tvShowOverview = mediaOverview as TvShowOverviewModel;
        title = tvShowOverview.name;
        genres = genreIdsToNames(tvShowGenres, tvShowOverview.genreIds);
        year = tvShowOverview.firstAirDate.split('-').first;
    }
    final imgOpacity = 0.85;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // media backdrop image with title, genres, etc on top
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(backdropPath ?? ''),
                  onError: (exception, stackTrace) =>
                      PlaceholderImage(opacity: imgOpacity),

                  fit: BoxFit.cover,
                  opacity: imgOpacity,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        radius: 16,
                        onTap: () => NavHelper.pop(context),
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$year • $genres',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${rating.toStringAsFixed(1)}/10',
                          style: textTheme.bodyMedium?.copyWith(
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '($votes votes)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // media content: action buttons, overview & see more
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MediaActionButtons(
                  mediaId: mediaOverview.id,
                  mediaType: type,
                  mediaOverview: mediaOverview,
                ),
                Text(
                  overview,
                  style: textTheme.bodyMedium,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
                TextButton(
                  onPressed: onMore,
                  child: Text('See More', style: textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
