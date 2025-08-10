import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class KnownForModel {
  final String? backdropPath;
  final int id;
  final String? title;
  final String? originalTitle;
  final String overview;
  final String? posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? releaseDate;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String? name;
  final String? originalName;
  final String? firstAirDate;
  final List<String>? originCountry;
  const KnownForModel({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.name,
    required this.originalName,
    required this.firstAirDate,
    required this.originCountry,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'name': name,
      'original_name': originalName,
      'first_air_date': firstAirDate,
      'origin_country': originCountry,
    };
  }

  @override
  String toString() {
    return 'KnownForModel(backdropPath: $backdropPath, id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, mediaType: $mediaType, adult: $adult, originalLanguage: $originalLanguage, genreIds: $genreIds, popularity: $popularity, releaseDate: $releaseDate, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, name: $name, originalName: $originalName, firstAirDate: $firstAirDate, originCountry: $originCountry)';
  }

  factory KnownForModel.fromMap(Map<String, dynamic> map) {
    return KnownForModel(
      backdropPath: map['backdrop_path'],
      id: map['id'],
      title: map['title'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      mediaType: map['media_type'],
      adult: map['adult'],
      originalLanguage: map['original_language'],
      genreIds: List<int>.from(map['genre_ids']),
      popularity: map['popularity'],
      releaseDate: map['release_date'],
      video: map['video'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
      name: map['name'],
      originalName: map['original_name'],
      firstAirDate: map['first_air_date'],
      originCountry: map['origin_country'] != null
          ? List<String>.from((map['origin_country']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KnownForModel.fromJson(String source) =>
      KnownForModel.fromMap(json.decode(source));
}
