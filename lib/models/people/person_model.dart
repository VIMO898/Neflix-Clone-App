import 'dart:convert';

import '../general/known_for_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PersonModel {
  final int id;
  final String name;
  final String originalName;
  final bool adult;
  final double popularity;
  final int gender;
  final String? mediaType;
  final String? knownForDepartment;
  final String? profilePath;
  final List<KnownForModel>? knownFor;
  PersonModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.mediaType,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.knownFor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'gender': gender,
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'popularity': popularity,
      'media_type': mediaType,
      'profile_path': profilePath,
      'known_for': knownFor?.map((x) => x.toMap()).toList(),
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      adult: map['adult'],
      gender: map['gender'],
      id: map['id'],
      knownForDepartment: map['known_for_department'],
      name: map['name'],
      originalName: map['original_name'],
      popularity: map['popularity'],
      profilePath: map['profile_path'],
      mediaType: map['media_type'],
      knownFor: map['known_for'] != null
          ? List<KnownForModel>.from(
              (map['known_for']).map<KnownForModel>(
                (x) => KnownForModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonModel(adult: $adult, gender: $gender, id: $id, knownForDepartment: $knownForDepartment, name: $name, originalName: $originalName, popularity: $popularity, profilePath: $profilePath, mediaType: $mediaType, knownFor: $knownFor)';
  }
}
