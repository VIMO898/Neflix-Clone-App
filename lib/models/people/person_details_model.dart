import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PersonDetailsModel {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final String? birthday;
  final String? deathday;
  final int gender;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;
  PersonDetailsModel({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'also_known_as': alsoKnownAs,
      'biography': biography,
      'birthday': birthday,
      'deathday': deathday,
      'gender': gender,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'known_for_department': knownForDepartment,
      'name': name,
      'place_of_birth': placeOfBirth,
      'popularity': popularity,
      'profile_path': profilePath,
    };
  }

  factory PersonDetailsModel.fromMap(Map<String, dynamic> map) {
    return PersonDetailsModel(
      adult: map['adult'],
      alsoKnownAs: List<String>.from((map['also_known_as'])),
      biography: map['biography'],
      birthday: map['birthday'],
      deathday: map['deathday'],
      gender: map['gender'],
      homepage: map['homepage'] as dynamic,
      id: map['id'],
      imdbId: map['imdb_id'],
      knownForDepartment: map['known_for_department'],
      name: map['name'],
      placeOfBirth: map['place_of_birth'],
      popularity: map['popularity'],
      profilePath: map['profile_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonDetailsModel.fromJson(String source) =>
      PersonDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonDetailsModel(adult: $adult, alsoKnownAs: $alsoKnownAs, biography: $biography, birthday: $birthday, deathday: $deathday, gender: $gender, homepage: $homepage, id: $id, imdbId: $imdbId, knownForDepartment: $knownForDepartment, name: $name, placeOfBirth: $placeOfBirth, popularity: $popularity, profilePath: $profilePath)';
  }
}
