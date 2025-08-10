import 'package:app/models/general/media_state_model.dart';
import 'package:app/models/movies/movie_details_model.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/repositories/hive_media_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shows/tv_show_details_model.dart';

class HiveMediaController extends StateNotifier<MediaStateModel> {
  final BaseHiveMediaRepository repo;
  HiveMediaController(this.repo)
    : super(MediaStateModel(movies: [], tvShows: [])) {
    getMediaState();
  }

  void getMediaState() {
    final movies = repo.getMovies();
    final tvShows = repo.getTvShows();
    if (movies.isEmpty && tvShows.isEmpty) return;
    state = MediaStateModel(movies: movies, tvShows: tvShows);
  }

  bool movieExists(int id) => repo.movieExists(id);
  bool tvShowExists(int id) => repo.tvShowExists(id);

  void addMovie(MovieOverviewModel movieOverview) async {
    if (movieExists(movieOverview.id)) return;
    state = state.copyWith(movies: [movieOverview, ...state.movies]);
    return repo.addMovie(movieOverview);
  }

  Future<void> addAllMovies(List<MovieOverviewModel> movies) {
    final unavailableMovies = movies
        .where((movie) => !movieExists(movie.id))
        .toList();
    state = state.copyWith(movies: [...state.movies, ...unavailableMovies]);
    return repo.addMovies(unavailableMovies);
  }

  void addTvShow(TvShowOverviewModel tvShowOverview) async {
    if (tvShowExists(tvShowOverview.id)) return;
    state = state.copyWith(tvShows: [tvShowOverview, ...state.tvShows]);
    return repo.addTvShow(tvShowOverview);
  }

  Future<void> addAllTvShows(List<TvShowOverviewModel> tvShows) {
    final unavailableTvShows = tvShows
        .where((tv) => !tvShowExists(tv.id))
        .toList();
    state = state.copyWith(tvShows: [...state.tvShows, ...unavailableTvShows]);
    return repo.addTvShows(unavailableTvShows);
  }

  Future<void> addMovieFromDetails(MovieDetailsModel movieDetails) async {
    if (movieExists(movieDetails.id)) return;
    final genresToGenreIds = movieDetails.genres.map((g) => g.id).toList();
    final movieOverview = MovieOverviewModel.fromJson(
      movieDetails.toJson(),
    ).copyWith(genreIds: genresToGenreIds);
    return addMovie(movieOverview);
  }

  Future<void> addTvShowFromDetails(TvShowDetailsModel tvShowDetails) async {
    final tvShowAlreadyExists = tvShowExists(tvShowDetails.id);
    if (tvShowAlreadyExists) return;
    final genresToGenreIds = tvShowDetails.genres.map((g) => g.id).toList();
    final tvShowOverview = TvShowOverviewModel.fromJson(
      tvShowDetails.toJson(),
    ).copyWith(genreIds: genresToGenreIds);
    return addTvShow(tvShowOverview);
  }

  Future<void> removeMovie(int id) async {
    if (!movieExists(id)) return;
    final updatedMovies = state.movies
        .where((movie) => movie.id != id)
        .toList();
    state = state.copyWith(movies: updatedMovies);
    return repo.removeMovie(id);
  }

  Future<void> removeTvShow(int id) async {
    if (!tvShowExists(id)) return;
    final updatedTvShows = state.tvShows
        .where((tvShow) => tvShow.id != id)
        .toList();
    state = state.copyWith(tvShows: updatedTvShows);
    return repo.removeTvShow(id);
  }
}
