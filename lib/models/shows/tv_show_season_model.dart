import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TvShowSeasonModel {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;
  TvShowSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }

  factory TvShowSeasonModel.fromMap(Map<String, dynamic> map) {
    return TvShowSeasonModel(
      airDate: map['air_date'],
      episodeCount: map['episode_count'],
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      seasonNumber: map['season_number'],
      voteAverage: map['vote_average'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TvShowSeasonModel.fromJson(String source) =>
      TvShowSeasonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowSeasonModel(airDate: $airDate, episodeCount: $episodeCount, id: $id, name: $name, overview: $overview, posterPath: $posterPath, seasonNumber: $seasonNumber, voteAverage: $voteAverage)';
  }
}
