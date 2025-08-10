import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/models/movies/movie_details_model.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_details_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';

dynamic converMediaDetailsToMediaOverview(
  ExploreMediaType type,
  dynamic mediaDetails,
) {
  switch (type) {
    case ExploreMediaType.movies:
      final movieDetails = mediaDetails as MovieDetailsModel;
      final mappedMovieDetails = movieDetails.toMap();
      mappedMovieDetails['genre_ids'] = movieDetails.genres
          .map((m) => m.id)
          .toList();
      return MovieOverviewModel.fromMap(mappedMovieDetails);
    case ExploreMediaType.tvShows:
      final tvShowDetails = mediaDetails as TvShowDetailsModel;
      final mappedTvShowDetails = tvShowDetails.toMap();
      mappedTvShowDetails['genre_ids'] = tvShowDetails.genres
          .map((m) => m.id)
          .toList();
      // log(mappedTvShowDetails.toString());
      final tvShowOverview = TvShowOverviewModel.fromMap(mappedTvShowDetails);
      log(tvShowOverview.toString());
      return tvShowOverview;
  }
}
