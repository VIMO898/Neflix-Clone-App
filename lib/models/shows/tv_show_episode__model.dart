import 'dart:convert';

import 'package:app/models/people/cast_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TvShowEpisodeModel {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final List<CastModel>? crew;
  final List<CastModel>? guestStars;
  TvShowEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.crew,
    required this.guestStars,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
      'crew': crew,
      'guest_stars': guestStars,
    };
  }

  factory TvShowEpisodeModel.fromMap(Map<String, dynamic> map) {
    return TvShowEpisodeModel(
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
      airDate: map['air_date'],
      episodeNumber: map['episode_number'],
      episodeType: map['episode_type'],
      productionCode: map['production_code'],
      runtime: map['runtime'],
      seasonNumber: map['season_number'],
      showId: map['show_id'],
      stillPath: map['still_path'],
      crew: map['crew'] != null
          ? List<CastModel>.from(
              map['crew'].map((crew) => CastModel.fromMap(crew)).toList(),
            )
          : null,
      guestStars: map['guest_stars'] != null
          ? List<CastModel>.from(
              map['guest_stars']
                  .map((crew) => CastModel.fromMap(crew))
                  .toList(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvShowEpisodeModel.fromJson(String source) =>
      TvShowEpisodeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowEpisodeToAirModel(id: $id, name: $name, overview: $overview, voteAverage: $voteAverage, voteCount: $voteCount, airDate: $airDate, episodeNumber: $episodeNumber, episodeType: $episodeType, productionCode: $productionCode, runtime: $runtime, seasonNumber: $seasonNumber, showId: $showId, stillPath: $stillPath, crew: $crew, guestStars: $guestStars)';
  }
}
