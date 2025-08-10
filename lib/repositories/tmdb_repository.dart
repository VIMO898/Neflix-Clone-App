import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/models/general/app_setting_model.dart';
import 'package:app/models/general/external_links_model.dart';
import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/models/media/categorized_media_image_model.dart';
import 'package:app/models/media/media_video_model.dart';
import 'package:app/models/people/credits_model.dart';
import 'package:app/models/people/person_details_model.dart';
import 'package:app/models/shows/tv_show_episode__model.dart';
import 'package:app/models/watch_providers/flatrate_model.dart';
import 'package:app/repositories/app_setting_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/people/person_model.dart';
import 'package:app/models/shows/tv_show_details_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import '../models/general/genre_model.dart';
import '../models/general/keyword_model.dart';
import '../models/movies/movie_details_model.dart';
import '../models/movies/movie_overview_model.dart';

abstract class BaseTmdbRepository {
  // Movies
  Future<TmdbResult<MovieOverviewModel>> getPopularMovies([int page = 1]);
  Future<TmdbResult<MovieOverviewModel>> getNowPlayingMovies([int page = 1]);
  Future<TmdbResult<MovieOverviewModel>> getTopRatedMovies([int page = 1]);
  Future<TmdbResult<MovieOverviewModel>> getTrendingMovies([int page = 1]);
  Future<TmdbResult<MovieOverviewModel>> getUpcomingMovies([int page = 1]);
  Future<TmdbResult<MovieOverviewModel>> getSimilarMovies(
    int movieId, [
    int page = 1,
  ]);
  Future<TmdbResult<MovieOverviewModel>> getMovieRecommendations(
    int movieId, [
    int page = 1,
  ]);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  // TV Shows
  Future<TmdbResult<TvShowOverviewModel>> getPopularTvShows([int page = 1]);
  Future<TmdbResult<TvShowOverviewModel>> getTopRatedTvShows([int page = 1]);
  Future<TmdbResult<TvShowOverviewModel>> getTrendingTvShows([int page = 1]);
  Future<TmdbResult<TvShowOverviewModel>> getOnTheAirTvShows([int page = 1]);
  Future<TmdbResult<TvShowOverviewModel>> getAiringTodayTvShows([int page = 1]);
  Future<TvShowDetailsModel> getTvShowDetails(int tvShowId);
  Future<List<TvShowEpisodeModel>> getTvShowSeasonEpisodes({
    required int tvShowId,
    required int seasonNumber,
  });
  Future<TmdbResult<TvShowOverviewModel>> getSimilarTvShows(
    int tvShowId, [
    int page = 1,
  ]);
  Future<TmdbResult<TvShowOverviewModel>> getTvShowRecommendations(
    int tvShowId, [
    int page = 1,
  ]);
  // discover
  Future<TmdbResult<MovieOverviewModel>> discoverMovies({
    required MediaDiscoveryFilterModel filters,
    int page = 1,
  });
  Future<TmdbResult<TvShowOverviewModel>> discoverTvShows({
    required MediaDiscoveryFilterModel filters,
    int page = 1,
  });
  // Media (images & videos)
  Future<CategorizedMediaImageModel> getMediaImages({
    required ExploreMediaType type,
    required int id,
  });
  Future<List<MediaVideoModel>> getMediaVideos({
    required ExploreMediaType type,
    required int id,
  });
  // Genres List
  Future<List<GenreModel>> getMovieGenres();
  Future<List<GenreModel>> getTvShowGenres();
  // People
  Future<TmdbResult<PersonModel>> getPopularPeople([int page = 1]);
  Future<TmdbResult<PersonModel>> getTrendingPeople({
    required PeopleTrendingTimeWindow trendingTimeWindowint,
    page = 1,
  });
  Future<CreditsModel> getMediaCredits({
    required ExploreMediaType type,
    required int id,
  });
  Future<PersonDetailsModel> getPersonDetails(int id);
  Future<List<MovieOverviewModel>> getPersonMovieCredits(int personId);
  Future<List<TvShowOverviewModel>> getPersonTvShowCredits(int personId);
  Future<ExternalLinksModel> getPersonExternalLinks(int personId);
  // Search
  Future<TmdbResult<MovieOverviewModel>> searchMovies(
    String query, [
    int page = 1,
  ]);
  Future<TmdbResult<TvShowOverviewModel>> searchTvShows(
    String query, [
    int page = 1,
  ]);
  Future<TmdbResult<PersonModel>> searchPeople(String query, [int page = 1]);

  // Watch Provider
  Future<List<FlatrateModel>> getWatchProvider({
    required ExploreMediaType type,
    required int mediaId,
  });
  // Keywords
  Future<TmdbResult<KeywordModel>> searchMediaKeywords(
    String query, [
    int page = 1,
  ]);
}

class TmdbRepository implements BaseTmdbRepository {
  final BaseAppSettingRepository appSettingRepo;
  TmdbRepository({required this.appSettingRepo});

  AppSettingModel? get appSettings => appSettingRepo.getAppSettings();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
    ),
  );

  Future<T> _request<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final qp = {
        'region': queryParameters?['region'] ?? appSettings?.region.iso31661,
        'language':
            queryParameters?['language'] ??
            appSettings?.preferredLanguage.iso6391,
        'include_adult':
            queryParameters?['include_adult'] ?? appSettings?.disableSafeMode,
      };
      if (queryParameters != null) qp.addAll(queryParameters);
      log({'path': path}.toString());
      log({'queryParameters': qp}.toString());
      final response = await _dio.get(path, queryParameters: qp);
      return parser(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      throw TmdbException(
        success: data?['success'] ?? false,
        statusCode: data?['status_code'] ?? 500,
        statusMessage: data?['status_message'] ?? 'Unknown error',
      );
    }
  }

  // Genre
  @override
  Future<List<GenreModel>> getMovieGenres() => _request(
    '/genre/movie/list',
    parser: (data) =>
        (data['genres'] as List).map((e) => GenreModel.fromMap(e)).toList(),
  );

  @override
  Future<List<GenreModel>> getTvShowGenres() => _request(
    '/genre/tv/list',
    parser: (data) =>
        (data['genres'] as List).map((e) => GenreModel.fromMap(e)).toList(),
  );

  // Movies
  @override
  Future<TmdbResult<MovieOverviewModel>> getPopularMovies([int page = 1]) =>
      _request(
        '/discover/movie',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
      );

  @override
  Future<TmdbResult<MovieOverviewModel>> getNowPlayingMovies([int page = 1]) =>
      _request(
        '/movie/now_playing',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
      );

  @override
  Future<TmdbResult<MovieOverviewModel>> getTopRatedMovies([int page = 1]) =>
      _request(
        '/movie/top_rated',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
      );

  @override
  Future<TmdbResult<MovieOverviewModel>> getTrendingMovies([int page = 1]) =>
      _request(
        '/trending/movie/day',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
      );

  @override
  Future<TmdbResult<MovieOverviewModel>> getUpcomingMovies([int page = 1]) =>
      _request(
        '/movie/upcoming',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
      );

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) => _request(
    '/movie/$movieId',
    parser: (data) => MovieDetailsModel.fromMap(data),
  );

  @override
  Future<TmdbResult<MovieOverviewModel>> getSimilarMovies(
    int movieId, [
    int page = 1,
  ]) {
    return _request(
      '/movie/$movieId/similar',
      queryParameters: {'page': page},
      parser: (data) =>
          TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
    );
  }

  @override
  Future<TmdbResult<MovieOverviewModel>> getMovieRecommendations(
    int movieId, [
    int page = 1,
  ]) {
    return _request(
      '/movie/$movieId/recommendations',
      queryParameters: {'page': page},
      parser: (data) =>
          TmdbResult.fromMap(data, (m) => MovieOverviewModel.fromMap(m)),
    );
  }

  // TV Shows
  @override
  Future<TmdbResult<TvShowOverviewModel>> getPopularTvShows([int page = 1]) =>
      _request(
        '/tv/popular',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (e) => TvShowOverviewModel.fromMap(e)),
      );

  @override
  Future<TmdbResult<TvShowOverviewModel>> getTopRatedTvShows([int page = 1]) =>
      _request(
        '/tv/top_rated',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (e) => TvShowOverviewModel.fromMap(e)),
      );

  @override
  Future<TmdbResult<TvShowOverviewModel>> getTrendingTvShows([int page = 1]) =>
      _request(
        '/trending/tv/day',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (e) => TvShowOverviewModel.fromMap(e)),
      );

  @override
  Future<TmdbResult<TvShowOverviewModel>> getOnTheAirTvShows([int page = 1]) =>
      _request(
        '/tv/on_the_air',
        queryParameters: {'page': page},
        parser: (data) =>
            TmdbResult.fromMap(data, (e) => TvShowOverviewModel.fromMap(e)),
      );

  @override
  Future<TmdbResult<TvShowOverviewModel>> getAiringTodayTvShows([
    int page = 1,
  ]) => _request(
    '/tv/airing_today',
    queryParameters: {'page': page},
    parser: (data) =>
        TmdbResult.fromMap(data, (e) => TvShowOverviewModel.fromMap(e)),
  );

  @override
  Future<TvShowDetailsModel> getTvShowDetails(int tvShowId) => _request(
    '/tv/$tvShowId',
    parser: (data) => TvShowDetailsModel.fromMap(data),
  );

  @override
  Future<CreditsModel> getMediaCredits({
    required ExploreMediaType type,
    required int id,
  }) {
    final media = switch (type) {
      ExploreMediaType.movies => 'movie',
      ExploreMediaType.tvShows => 'tv',
    };
    return _request(
      '/$media/$id/credits',
      parser: (data) => CreditsModel.fromMap(data),
    );
  }

  @override
  Future<List<TvShowEpisodeModel>> getTvShowSeasonEpisodes({
    required int tvShowId,
    required int seasonNumber,
  }) {
    return _request(
      '/tv/$tvShowId/season/$seasonNumber',
      parser: (data) => (data['episodes'] as List)
          .map((e) => TvShowEpisodeModel.fromMap(e))
          .toList(),
    );
  }

  @override
  Future<TmdbResult<TvShowOverviewModel>> getSimilarTvShows(
    int tvShowId, [
    int page = 1,
  ]) {
    return _request(
      '/tv/$tvShowId/similar',
      queryParameters: {'page': page},
      parser: (data) => TmdbResult.fromMap(data, (m) {
        return TvShowOverviewModel.fromMap(m);
      }),
    );
  }

  @override
  Future<TmdbResult<TvShowOverviewModel>> getTvShowRecommendations(
    int tvShowId, [
    int page = 1,
  ]) {
    return _request(
      '/tv/$tvShowId/recommendations',
      queryParameters: {'page': page},
      parser: (data) =>
          TmdbResult.fromMap(data, (m) => TvShowOverviewModel.fromMap(m)),
    );
  }

  // People
  @override
  Future<TmdbResult<PersonModel>> getPopularPeople([int page = 1]) => _request(
    '/person/popular',
    queryParameters: {'page': page},
    parser: (data) => TmdbResult.fromMap(data, (e) => PersonModel.fromMap(e)),
  );

  @override
  Future<TmdbResult<PersonModel>> getTrendingPeople({
    required PeopleTrendingTimeWindow trendingTimeWindowint,
    page = 1,
  }) => _request(
    '/trending/person/${trendingTimeWindowint.name}',
    queryParameters: {'page': page},
    parser: (data) {
      return TmdbResult.fromMap(data, (e) => PersonModel.fromMap(e));
    },
  );

  @override
  Future<PersonDetailsModel> getPersonDetails(int id) {
    return _request(
      '/person/$id',
      parser: (data) => PersonDetailsModel.fromMap(data),
    );
  }

  @override
  Future<List<MovieOverviewModel>> getPersonMovieCredits(int personId) {
    return _request(
      '/person/$personId/movie_credits',
      parser: (data) => (data['cast'] as List)
          .map((m) => MovieOverviewModel.fromMap(m))
          .toList(),
    );
  }

  @override
  Future<List<TvShowOverviewModel>> getPersonTvShowCredits(int personId) {
    return _request(
      '/person/$personId/tv_credits',
      parser: (data) => (data['cast'] as List)
          .map((m) => TvShowOverviewModel.fromMap(m))
          .toList(),
    );
  }

  @override
  Future<ExternalLinksModel> getPersonExternalLinks(int personId) {
    return _request(
      '/person/$personId/external_ids',
      parser: (data) => ExternalLinksModel.fromMap(data),
    );
  }

  // discover
  String _generateMediaDiscoveryPath({
    required ExploreMediaType mediaType,
    required MediaDiscoveryFilterModel filters,
    int page = 1,
  }) {
    final isMediaMovie = mediaType == ExploreMediaType.movies;
    final queryParams = <String>[];

    final genreIds = filters.genres?.map((g) => g.id).join(',');
    if (genreIds != null && genreIds.isNotEmpty) {
      queryParams.add('with_genres=$genreIds');
    }
    final ratings = filters.ratings;
    if (ratings != null) {
      if (ratings.min != null) {
        queryParams.add('vote_average.gte=${ratings.min}');
      }
      if (ratings.max != null) {
        queryParams.add('vote_average.lte=${ratings.max}');
      }
    }
    final voteCount = filters.voteCount;
    if (voteCount != null) {
      if (voteCount.min != null) {
        queryParams.add('vote_count.gte=${voteCount.min}');
      }
      if (voteCount.max != null) {
        queryParams.add('vote_count.lte=${voteCount.max}');
      }
    }
    final releaseYearRange = filters.releaseYearRange;
    if (releaseYearRange != null) {
      final String mediaReleaseDateQueryParamLabel = switch (mediaType) {
        ExploreMediaType.movies => 'primary_release_date',
        ExploreMediaType.tvShows => 'first_air_date',
      };
      if (releaseYearRange.from != null) {
        queryParams.add(
          '$mediaReleaseDateQueryParamLabel.gte=${releaseYearRange.from}-01-01',
        );
      }
      if (releaseYearRange.to != null) {
        queryParams.add(
          '$mediaReleaseDateQueryParamLabel.lte=${releaseYearRange.to}-12-31',
        );
      }
    }

    if (filters.withOriginCountry != null) {
      queryParams.add('with_origin_country=${filters.withOriginCountry}');
    }

    if (filters.withOriginalLanguage != null) {
      queryParams.add('with_original_language=${filters.withOriginalLanguage}');
    }

    if (filters.includeAdult != null) {
      queryParams.add('include_adult=${filters.includeAdult}');
    } else {
      final includeAdult = appSettings?.disableSafeMode ?? false;
      queryParams.add('include_adult=$includeAdult');
    }

    final runtimeRange = filters.runtimeRange;
    if (runtimeRange != null) {
      if (runtimeRange.min != null) {
        queryParams.add('with_runtime.gte=${runtimeRange.min}');
      }
      if (runtimeRange.max != null) {
        queryParams.add('with_runtime.lte=${runtimeRange.max}');
      }
    }

    final sortBy = switch (filters.sortBy) {
      null => SortBy.popularity.name,
      SortBy.popularity => SortBy.popularity.name,
      SortBy.rating => 'vote_average',
      SortBy.releaseDate =>
        isMediaMovie ? 'primary_release_date' : 'first_air_date',
    };
    final sortOrder = switch (filters.sortOrder) {
      SortOrder.descending => 'desc',
      _ => 'asc',
    };
    queryParams.add('sort_by=$sortBy.$sortOrder');
    queryParams.add('page=$page');

    final path =
        '$baseUrl/discover/${isMediaMovie ? "movie" : 'tv'}?${queryParams.join('&')}';
    log(path);
    return path;
  }

  @override
  Future<TmdbResult<MovieOverviewModel>> discoverMovies({
    required MediaDiscoveryFilterModel filters,
    int page = 1,
  }) {
    final path = _generateMediaDiscoveryPath(
      mediaType: ExploreMediaType.movies,
      filters: filters,
    );
    final pathWithPage = '$path&page=$page';
    return _request(
      pathWithPage,
      parser: (data) {
        return TmdbResult<MovieOverviewModel>.fromMap(
          data,
          (m) => MovieOverviewModel.fromMap(m),
        );
      },
    );
  }

  @override
  Future<TmdbResult<TvShowOverviewModel>> discoverTvShows({
    required MediaDiscoveryFilterModel filters,
    int page = 1,
  }) {
    final path = _generateMediaDiscoveryPath(
      mediaType: ExploreMediaType.tvShows,
      filters: filters,
    );
    final pathWithPage = '$path&page=$page';
    return _request(
      pathWithPage,
      parser: (data) {
        return TmdbResult<TvShowOverviewModel>.fromMap(
          data,
          (m) => TvShowOverviewModel.fromMap(m),
        );
      },
    );
  }

  // Media(images & videos)
  @override
  Future<CategorizedMediaImageModel> getMediaImages({
    required ExploreMediaType type,
    required int id,
  }) {
    final media = switch (type) {
      ExploreMediaType.movies => 'movie',
      ExploreMediaType.tvShows => 'tv',
    };
    return _request(
      '/$media/$id/images',
      parser: (data) => CategorizedMediaImageModel.fromMap(data),
    );
  }

  @override
  Future<List<MediaVideoModel>> getMediaVideos({
    required ExploreMediaType type,
    required int id,
  }) {
    final media = switch (type) {
      ExploreMediaType.movies => 'movie',
      ExploreMediaType.tvShows => 'tv',
    };
    return _request(
      '/$media/$id/videos',
      parser: (data) {
        return (data['results'] as List)
            .map((e) => MediaVideoModel.fromMap(e))
            .toList();
      },
    );
  }

  // Search
  @override
  Future<TmdbResult<MovieOverviewModel>> searchMovies(
    String query, [
    int page = 1,
  ]) => _request(
    '/search/movie',
    queryParameters: {'query': query, 'page': page},
    parser: (data) {
      return TmdbResult<MovieOverviewModel>.fromMap(
        data,
        (m) => MovieOverviewModel.fromMap(m),
      );
    },
  );

  @override
  Future<TmdbResult<TvShowOverviewModel>> searchTvShows(
    String query, [
    int page = 1,
  ]) => _request(
    '/search/tv',
    queryParameters: {'query': query, 'page': page},
    parser: (data) {
      return TmdbResult<TvShowOverviewModel>.fromMap(
        data,
        (t) => TvShowOverviewModel.fromMap(t),
      );
    },
  );

  @override
  Future<TmdbResult<PersonModel>> searchPeople(String query, [int page = 1]) =>
      _request(
        '/search/person',
        queryParameters: {'query': query, 'page': page},
        parser: (data) {
          return TmdbResult<PersonModel>.fromMap(
            data,
            (p) => PersonModel.fromMap(p),
          );
        },
      );

  // Watch Provider

  @override
  Future<List<FlatrateModel>> getWatchProvider({
    required ExploreMediaType type,
    required int mediaId,
  }) {
    final mediaName = switch (type) {
      ExploreMediaType.movies => 'movie',
      ExploreMediaType.tvShows => 'tv',
    };
    return _request(
      '/$mediaName/$mediaId/watch/providers',
      parser: (data) {
        final Map<String, dynamic> results = data['results'] ?? {};
        final List<FlatrateModel> matchedProviders = [];

        for (final country in results.entries) {
          final Map<String, dynamic> countryData = country.value;
          for (final type in ['flatrate', 'buy', 'rent', 'ads']) {
            if (countryData[type] != null && countryData[type] is List) {
              for (final provider in countryData[type]) {
                final contains = matchedProviders.any(
                  (p) => p.providerName == provider['provider_name'],
                );
                if (!contains) {
                  matchedProviders.add(FlatrateModel.fromMap(provider));
                }
              }
            }
          }
        }
        return matchedProviders;
      },
    );
  }

  // Keywords
  @override
  Future<TmdbResult<KeywordModel>> searchMediaKeywords(
    String query, [
    int page = 1,
  ]) {
    return _request(
      '/search/keyword',
      queryParameters: {'query': query, 'page': page},
      parser: (data) =>
          TmdbResult.fromMap(data, (k) => KeywordModel.fromMap(k)),
    );
  }
}
