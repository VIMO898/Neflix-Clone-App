import 'package:app/models/general/genre_model.dart';
import 'package:app/models/general/keyword_model.dart';
import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/screens/media_grid_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/enums.dart';
import '../utils/navigator_shortcuts.dart';
import '../widgets/discover/lazy_future_horizontal_media_list_view.dart';
import '../widgets/discover/media_carousel_slider.dart';

final _actionHitMovieFilters = MediaDiscoveryFilterModel(
  genres: [GenreModel(id: 28, name: "Action")],
  sortBy: SortBy.popularity,
  sortOrder: SortOrder.descending,
);

final _hiddenGemMovieFilters = MediaDiscoveryFilterModel(
  voteCount: (min: 500, max: null),
  ratings: (min: 8.0, max: null),
  sortBy: SortBy.rating,
  sortOrder: SortOrder.descending,
);

final _nostalgiaNightMovieFilters = MediaDiscoveryFilterModel(
  releaseYearRange: (from: 1980, to: 1989),
  sortBy: SortBy.popularity,
  sortOrder: SortOrder.descending,
);

final _awardWinnerMovieFilters = MediaDiscoveryFilterModel(
  keywords: [KeywordModel(id: 337571, name: "oscar-winner")],
  sortBy: SortBy.popularity,
  sortOrder: SortOrder.descending,
);

final _bingeWorthyMiniSeriesFilters = MediaDiscoveryFilterModel(
  runtimeRange: (min: 120, max: 360),
  sortBy: SortBy.rating,
  sortOrder: SortOrder.descending,
);

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  // filters

  @override
  Widget build(BuildContext context, ref) {
    final tmdbRepo = ref.watch(tmdbRepoProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          MediaCarouselSlider(),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Hot Movies',
            mediaFutureBuilder: () => tmdbRepo.getTrendingMovies(),
            mediaCategory: MovieCategory.trending,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.tvShows,
            title: 'Hot TV Shows',
            mediaFutureBuilder: () => tmdbRepo.getTrendingTvShows(),
            mediaCategory: TvShowCategory.trending,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Popular Movies',
            mediaFutureBuilder: () => tmdbRepo.getPopularMovies(),
            mediaCategory: MovieCategory.popular,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.tvShows,
            title: 'Popular TV Shows',
            mediaFutureBuilder: () => tmdbRepo.getPopularTvShows(),
            mediaCategory: TvShowCategory.popular,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Top-Rated Movies',
            mediaFutureBuilder: () => tmdbRepo.getTopRatedMovies(),
            mediaCategory: MovieCategory.topRated,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.tvShows,
            title: 'Top-Rated TV Shows',
            mediaFutureBuilder: () => tmdbRepo.getTopRatedTvShows(),
            mediaCategory: TvShowCategory.trending,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'In Cinemas Now',
            mediaFutureBuilder: () => tmdbRepo.getNowPlayingMovies(),
            mediaCategory: MovieCategory.nowPlaying,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.tvShows,
            title: 'On Tonight',
            mediaFutureBuilder: () => tmdbRepo.getAiringTodayTvShows(),
            mediaCategory: TvShowCategory.airingToday,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Coming Soon (Movies)',
            mediaFutureBuilder: () => tmdbRepo.getUpcomingMovies(),
            mediaCategory: MovieCategory.upcoming,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.tvShows,
            title: 'New This Week (TV)',
            mediaFutureBuilder: () => tmdbRepo.getOnTheAirTvShows(),
            mediaCategory: TvShowCategory.onTheAir,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.people,
            title: 'Trending Celebs',
            mediaFutureBuilder: () => tmdbRepo.getTrendingPeople(
              trendingTimeWindowint: PeopleTrendingTimeWindow.week,
            ),
            mediaCategory: PersonCategory.trending,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Action Hits',
            mediaFutureBuilder: () =>
                tmdbRepo.discoverMovies(filters: _actionHitMovieFilters),
            filters: _actionHitMovieFilters,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Hidden Gems',
            mediaFutureBuilder: () =>
                tmdbRepo.discoverMovies(filters: _hiddenGemMovieFilters),
            filters: _hiddenGemMovieFilters,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Binge-Worthy Mini-Series',
            mediaFutureBuilder: () =>
                tmdbRepo.discoverMovies(filters: _bingeWorthyMiniSeriesFilters),
            filters: _bingeWorthyMiniSeriesFilters,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Nostalgia Night (80s)',
            mediaFutureBuilder: () =>
                tmdbRepo.discoverMovies(filters: _nostalgiaNightMovieFilters),
            filters: _nostalgiaNightMovieFilters,
          ),
          _buildHorizontalMediaListView(
            context,
            AllMediaType.movies,
            title: 'Award Winners',
            mediaFutureBuilder: () =>
                tmdbRepo.discoverMovies(filters: _awardWinnerMovieFilters),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMediaListView(
    BuildContext context,
    AllMediaType type, {
    required String title,
    required Future<TmdbResult> Function() mediaFutureBuilder,
    Enum? mediaCategory,
    MediaDiscoveryFilterModel? filters,
  }) {
    return LazyFutureHorizontalMediaListView(
      mediaType: type,
      title: title,
      mediaFutureBuilder: mediaFutureBuilder,
      onMore: () => NavHelper.push(
        context,
        MediaGridViewScreen.withScaffold(
          type: type,
          appbarTitle: title,
          mediaCategory: mediaCategory,
          filters: filters,
        ),
      ),
    );
  }
}
