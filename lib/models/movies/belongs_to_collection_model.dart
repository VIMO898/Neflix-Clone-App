import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class BelongsToCollectionModel {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;
  BelongsToCollectionModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }

  factory BelongsToCollectionModel.fromMap(Map<String, dynamic> map) {
    return BelongsToCollectionModel(
      id: map['id'],
      name: map['name'],
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BelongsToCollectionModel.fromJson(String source) =>
      BelongsToCollectionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BelongsToCollectionModel(id: $id, name: $name, posterPath: $posterPath, backdropPath: $backdropPath)';
  }
}
