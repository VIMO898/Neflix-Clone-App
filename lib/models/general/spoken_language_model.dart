import 'dart:convert';

import 'package:app/models/general/selectable_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SpokenLanguageModel {
  final String englishName;
  final String iso6391;
  final String name;
  SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }

  factory SpokenLanguageModel.fromMap(Map<String, dynamic> map) {
    return SpokenLanguageModel(
      englishName: map['english_name'],
      iso6391: map['iso_639_1'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpokenLanguageModel.fromJson(String source) =>
      SpokenLanguageModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SpokenLanguageModel(englishName: $englishName, iso6391: $iso6391, name: $name)';

  SelectableModel toSelectable() {
    return SelectableModel(iso: iso6391, englishName: englishName, name: name);
  }

  @override
  bool operator ==(covariant SpokenLanguageModel other) {
    if (identical(this, other)) return true;

    return other.englishName == englishName &&
        other.iso6391 == iso6391 &&
        other.name == name;
  }

  @override
  int get hashCode => englishName.hashCode ^ iso6391.hashCode ^ name.hashCode;
}
