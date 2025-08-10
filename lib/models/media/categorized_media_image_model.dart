// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/media/media_image_model.dart';

class CategorizedMediaImageModel {
  final int id;
  final List<MediaImageModel> backdrops;
  final List<MediaImageModel> logos;
  final List<MediaImageModel> posters;
  CategorizedMediaImageModel({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  @override
  String toString() =>
      'CategorizedMediaImage(id: $id, backdrops: $backdrops, logos: $logos, posters: $posters)';

  CategorizedMediaImageModel copyWith({
    int? id,
    List<MediaImageModel>? backdrops,
    List<MediaImageModel>? logos,
    List<MediaImageModel>? posters,
  }) {
    return CategorizedMediaImageModel(
      id: id ?? this.id,
      backdrops: backdrops ?? this.backdrops,
      logos: logos ?? this.logos,
      posters: posters ?? this.posters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'backdrops': backdrops.map((x) => x.toMap()).toList(),
      'logos': logos.map((x) => x.toMap()).toList(),
      'posters': posters.map((x) => x.toMap()).toList(),
    };
  }

  factory CategorizedMediaImageModel.fromMap(Map<String, dynamic> map) {
    return CategorizedMediaImageModel(
      id: map['id'],
      backdrops: List<MediaImageModel>.from(
          map['backdrops'].map((x) => MediaImageModel.fromMap(x))),
      logos: List<MediaImageModel>.from(
          map['logos'].map((x) => MediaImageModel.fromMap(x))),
      posters: List<MediaImageModel>.from(
          map['posters'].map((x) => MediaImageModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorizedMediaImageModel.fromJson(String source) =>
      CategorizedMediaImageModel.fromMap(json.decode(source));
}
