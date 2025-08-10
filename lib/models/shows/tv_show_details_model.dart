// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/general/genre_model.dart';

import '../general/production_country_model.dart';
import '../general/spoken_language_model.dart';
import 'network_model.dart';
import 'tv_show_created_by_model.dart';
import 'tv_show_episode__model.dart';
import 'tv_show_season_model.dart';

class TvShowDetailsModel {
  final bool adult;
  final String? backdropPath;
  final List<TvShowCreatedByModel> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final TvShowEpisodeModel? lastEpisodeToAir;
  final String name;
  final TvShowEpisodeModel? nextEpisodeToAir;
  final List<NetworkModel> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<NetworkModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final List<TvShowSeasonModel> seasons;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  TvShowDetailsModel({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  String toString() {
    return 'TvShowDetails(adult: $adult, backdropPath: $backdropPath, createdBy: $createdBy, episodeRunTime: $episodeRunTime, firstAirDate: $firstAirDate, genres: $genres, homepage: $homepage, id: $id, inProduction: $inProduction, languages: $languages, lastAirDate: $lastAirDate, lastEpisodeToAir: $lastEpisodeToAir, name: $name, nextEpisodeToAir: $nextEpisodeToAir, networks: $networks, numberOfEpisodes: $numberOfEpisodes, numberOfSeasons: $numberOfSeasons, originCountry: $originCountry, originalLanguage: $originalLanguage, originalName: $originalName, overview: $overview, popularity: $popularity, posterPath: $posterPath, productionCompanies: $productionCompanies, productionCountries: $productionCountries, seasons: $seasons, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, type: $type, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdrop_path': backdropPath,
      'createdBy': createdBy.map((x) => x.toMap()).toList(),
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate,
      'genres': genres,
      'homepage': homepage,
      'id': id,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir?.toMap(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir?.toMap(),
      'networks': networks.map((x) => x.toMap()).toList(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies.map((x) => x.toMap()).toList(),
      'production_countries':
          productionCountries.map((x) => x.toMap()).toList(),
      'seasons': seasons.map((x) => x.toMap()).toList(),
      'spoken_languages': spokenLanguages.map((x) => x.toMap()).toList(),
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory TvShowDetailsModel.fromMap(Map<String, dynamic> map) {
    return TvShowDetailsModel(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      createdBy: List<TvShowCreatedByModel>.from(
        (map['created_by']).map(
          (x) => TvShowCreatedByModel.fromMap(x),
        ),
      ),
      episodeRunTime: List<int>.from(map['episode_run_time']),
      firstAirDate: map['first_air_date'],
      genres: List<GenreModel>.from(
        (map['genres']).map(
          (x) => GenreModel.fromMap(x),
        ),
      ),
      homepage: map['homepage'],
      id: map['id'],
      inProduction: map['in_production'],
      languages: List<String>.from((map['languages'])),
      lastAirDate: map['last_air_date'],
      lastEpisodeToAir: map['last_episode_to_air'] == null
          ? null
          : TvShowEpisodeModel.fromMap(map['last_episode_to_air']),
      name: map['name'],
      nextEpisodeToAir: map['next_episode_to_air'] == null
          ? null
          : TvShowEpisodeModel.fromMap(map['next_episode_to_air']),
      networks: List<NetworkModel>.from(
        (map['networks']).map<NetworkModel>(
          (x) => NetworkModel.fromMap(x),
        ),
      ),
      numberOfEpisodes: map['number_of_episodes'],
      numberOfSeasons: map['number_of_seasons'],
      originCountry: List<String>.from((map['origin_country'])),
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      productionCompanies: List<NetworkModel>.from(
        (map['production_companies']).map<NetworkModel>(
          (x) => NetworkModel.fromMap(x),
        ),
      ),
      productionCountries: List<ProductionCountryModel>.from(
        (map['production_countries']).map<ProductionCountryModel>(
          (x) => ProductionCountryModel.fromMap(x),
        ),
      ),
      seasons: List<TvShowSeasonModel>.from(
        (map['seasons']).map<TvShowSeasonModel>(
          (x) => TvShowSeasonModel.fromMap(x),
        ),
      ),
      spokenLanguages: List<SpokenLanguageModel>.from(
        (map['spoken_languages']).map<SpokenLanguageModel>(
          (x) => SpokenLanguageModel.fromMap(x),
        ),
      ),
      status: map['status'],
      tagline: map['tagline'],
      type: map['type'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TvShowDetailsModel.fromJson(String source) =>
      TvShowDetailsModel.fromMap(json.decode(source));
}
