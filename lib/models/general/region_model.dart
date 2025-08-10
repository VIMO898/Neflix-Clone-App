import 'dart:convert';

import 'selectable_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegionModel {
  final String iso31661;
  final String englishName;
  final String nativeName;
  RegionModel({
    required this.iso31661,
    required this.englishName,
    required this.nativeName,
  });

  @override
  String toString() =>
      'RegionModel(iso31661: $iso31661, englishName: $englishName, nativeName: $nativeName)';

  RegionModel copyWith({
    String? iso31661,
    String? englishName,
    String? nativeName,
  }) {
    return RegionModel(
      iso31661: iso31661 ?? this.iso31661,
      englishName: englishName ?? this.englishName,
      nativeName: nativeName ?? this.nativeName,
    );
  }

  @override
  bool operator ==(covariant RegionModel other) {
    if (identical(this, other)) return true;

    return other.iso31661 == iso31661 &&
        other.englishName == englishName &&
        other.nativeName == nativeName;
  }

  @override
  int get hashCode =>
      iso31661.hashCode ^ englishName.hashCode ^ nativeName.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso_3166_1': iso31661,
      'english_name': englishName,
      'native_name': nativeName,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      iso31661: map['iso_3166_1'],
      englishName: map['english_name'],
      nativeName: map['native_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source));

  SelectableModel toSelectable() {
    return SelectableModel(
      iso: iso31661,
      englishName: englishName,
      name: nativeName,
    );
  }
}
