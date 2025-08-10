// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/people/cast_model.dart';

class CreditsModel {
  final int id;
  final List<CastModel> cast;
  final List<CastModel> crew;
  CreditsModel({
    required this.id,
    required this.cast,
    required this.crew,
  });

  @override
  String toString() => 'CreditsModel(id: $id, cast: $cast, crew: $crew)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cast': cast.map((x) => x.toMap()).toList(),
      'crew': crew.map((x) => x.toMap()).toList(),
    };
  }

  factory CreditsModel.fromMap(Map<String, dynamic> map) {
    return CreditsModel(
      id: map['id'],
      cast: List<CastModel>.from(
          (map['cast']).map<CastModel>((x) => CastModel.fromMap(x))),
      crew: List<CastModel>.from(
          (map['crew']).map<CastModel>((x) => CastModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditsModel.fromJson(String source) =>
      CreditsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
