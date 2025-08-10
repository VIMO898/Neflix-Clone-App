// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class GenreModel {
  final int id;
  final String name;
  final String? localImgSrc;
  const GenreModel({
    required this.id,
    required this.name,
    this.localImgSrc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'local_img_src': localImgSrc,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
        id: map['id'], name: map['name'], localImgSrc: map['local_img_src']);
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) =>
      GenreModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'GenreModel(id: $id, name: $name, localImgSrc: $localImgSrc)';
}
