import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TvShowCreatedByModel {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;
  TvShowCreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'credit_id': creditId,
      'name': name,
      'original_name': originalName,
      'gender': gender,
      'profile_path': profilePath,
    };
  }

  factory TvShowCreatedByModel.fromMap(Map<String, dynamic> map) {
    return TvShowCreatedByModel(
      id: map['id'],
      creditId: map['credit_id'],
      name: map['name'],
      originalName: map['original_name'],
      gender: map['gender'],
      profilePath: map['profile_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TvShowCreatedByModel.fromJson(String source) =>
      TvShowCreatedByModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowCreatedByModel(id: $id, creditId: $creditId, name: $name, originalName: $originalName, gender: $gender, profilePath: $profilePath)';
  }
}
