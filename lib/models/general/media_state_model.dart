// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../movies/movie_overview_model.dart';
import '../shows/tv_show_overview_model.dart';

class MediaStateModel {
  final List<MovieOverviewModel> movies;
  final List<TvShowOverviewModel> tvShows;

  MediaStateModel({required this.movies, required this.tvShows});

  MediaStateModel copyWith(
      {List<MovieOverviewModel>? movies, List<TvShowOverviewModel>? tvShows}) {
    return MediaStateModel(
      movies: movies ?? this.movies,
      tvShows: tvShows ?? this.tvShows,
    );
  }

  @override
  String toString() => 'MediaStateModel(movies: $movies, tvShows: $tvShows)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movies': movies.map((x) => x.toMap()).toList(),
      'tvShows': tvShows.map((x) => x.toMap()).toList(),
    };
  }

  factory MediaStateModel.fromMap(Map<String, dynamic> map) {
    return MediaStateModel(
      movies: List<MovieOverviewModel>.from((map['movies'])
          .map<MovieOverviewModel>((x) => MovieOverviewModel.fromMap(x))),
      tvShows: List<TvShowOverviewModel>.from((map['tvShows'])
          .map<TvShowOverviewModel>((x) => TvShowOverviewModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaStateModel.fromJson(String source) =>
      MediaStateModel.fromMap(json.decode(source));
}
