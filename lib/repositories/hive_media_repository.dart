import 'package:hive_flutter/hive_flutter.dart';

import '../models/movies/movie_overview_model.dart';
import '../models/shows/tv_show_overview_model.dart';

abstract class BaseHiveMediaRepository {
  Future<void> addMovie(MovieOverviewModel movieOverview);
  Future<void> addMovies(List<MovieOverviewModel> movieOverviewList);
  Future<void> addTvShow(TvShowOverviewModel tvShowOverview);
  addTvShows(List<TvShowOverviewModel> tvShowOverviewList);
  Future<void> removeMovie(int id);
  Future<void> removeTvShow(int id);
  bool movieExists(int movieId);
  bool tvShowExists(int tvShowId);
  List<MovieOverviewModel> getMovies();
  List<TvShowOverviewModel> getTvShows();
}

class HiveMediaRepository implements BaseHiveMediaRepository {
  final Box movieBox;
  final Box tvShowBox;

  const HiveMediaRepository({required this.movieBox, required this.tvShowBox});

  @override
  Future<void> addMovie(MovieOverviewModel movieOverview) async {
    final movieAlreadyExists = movieExists(movieOverview.id);
    if (movieAlreadyExists) return;
    return movieBox.put(movieOverview.id, movieOverview.toJson());
  }

  @override
  Future<void> addMovies(List<MovieOverviewModel> movieOverviewList) async {
    Map<int, String> movieOverviewJsonMap = {};
    for (final movieOverview in movieOverviewList) {
      movieOverviewJsonMap.addEntries([
        MapEntry(movieOverview.id, movieOverview.toJson()),
      ]);
    }
    return movieBox.putAll(movieOverviewJsonMap);
  }

  @override
  Future<void> addTvShow(TvShowOverviewModel tvShowOverview) async {
    final tvShowAlreadyExists = movieExists(tvShowOverview.id);
    if (tvShowAlreadyExists) return;
    return tvShowBox.put(tvShowOverview.id, tvShowOverview.toJson());
  }

  @override
  Future<void> addTvShows(List<TvShowOverviewModel> tvShowOverviewList) async {
    Map<int, String> tvShowOverviewJsonMap = {};
    for (final tvShowOverview in tvShowOverviewList) {
      tvShowOverviewJsonMap.addEntries([
        MapEntry(tvShowOverview.id, tvShowOverview.toJson()),
      ]);
    }
    return tvShowBox.putAll(tvShowOverviewJsonMap);
  }

  @override
  bool movieExists(int movieId) => movieBox.containsKey(movieId);

  @override
  bool tvShowExists(int tvShowId) => tvShowBox.containsKey(tvShowId);

  @override
  List<MovieOverviewModel> getMovies() {
    if (tvShowBox.values.isEmpty) return [];
    return movieBox.values
        .map((movieJson) => MovieOverviewModel.fromJson(movieJson))
        .toList();
  }

  @override
  List<TvShowOverviewModel> getTvShows() {
    if (tvShowBox.values.isEmpty) return [];
    return tvShowBox.values
        .map((tvShowJson) => TvShowOverviewModel.fromJson(tvShowJson))
        .toList();
  }

  @override
  Future<void> removeMovie(int id) async {
    final exists = movieExists(id);
    if (!exists) return;
    return movieBox.delete(id);
  }

  @override
  Future<void> removeTvShow(int id) async {
    final exists = tvShowExists(id);
    if (!exists) return;
    return tvShowBox.delete(id);
  }
}
