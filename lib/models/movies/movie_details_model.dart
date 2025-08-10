// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../general/genre_model.dart';
import '../general/production_company_model.dart';
import '../general/production_country_model.dart';
import '../general/spoken_language_model.dart';
import 'belongs_to_collection_model.dart';

class MovieDetailsModel {
  final bool adult;
  final String? backdropPath;
  final BelongsToCollectionModel? belongsToCollection;
  final int budget;
  final List<GenreModel> genres;
  final String? homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanyModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  MovieDetailsModel({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection?.toMap(),
      'budget': budget,
      'genres': genres.map((x) => x.toMap()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies.map((x) => x.toMap()).toList(),
      'production_countries':
          productionCountries.map((x) => x.toMap()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages.map((x) => x.toMap()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      belongsToCollection: map['belongs_to_collection'] != null
          ? BelongsToCollectionModel.fromMap(map['belongs_to_collection'])
          : null,
      budget: map['budget'],
      genres: List<GenreModel>.from(
        (map['genres']).map<GenreModel>(
          (x) => GenreModel.fromMap(x),
        ),
      ),
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originCountry: List<String>.from((map['origin_country'])),
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      productionCompanies: List<ProductionCompanyModel>.from(
          (map['production_companies']).map<ProductionCompanyModel>(
        (x) => ProductionCompanyModel.fromMap(x),
      )),
      productionCountries: List<ProductionCountryModel>.from(
        (map['production_countries']).map<ProductionCountryModel>(
          (x) => ProductionCountryModel.fromMap(x),
        ),
      ),
      releaseDate: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      spokenLanguages: List<SpokenLanguageModel>.from(
        (map['spoken_languages']).map<SpokenLanguageModel>(
          (x) => SpokenLanguageModel.fromMap(x),
        ),
      ),
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailsModel.fromJson(String source) =>
      MovieDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieDetailsModel(adult: $adult, backdropPath: $backdropPath, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homepage: $homepage, id: $id, imdbId: $imdbId, originCountry: $originCountry, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, productionCompanies: $productionCompanies, productionCountries: $productionCountries, releaseDate: $releaseDate, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
