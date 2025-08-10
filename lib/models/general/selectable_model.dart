// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app/models/general/region_model.dart';
import 'package:app/models/general/spoken_language_model.dart';

class SelectableModel {
  final String iso;
  final String englishName;
  final String name;
  SelectableModel({
    required this.iso,
    required this.englishName,
    required this.name,
  });

  SpokenLanguageModel toSpokenLanguage() {
    return SpokenLanguageModel(
      englishName: englishName,
      iso6391: iso,
      name: name,
    );
  }

  RegionModel toRegion() {
    return RegionModel(
      iso31661: iso,
      englishName: englishName,
      nativeName: name,
    );
  }

  @override
  String toString() =>
      'SelectableModel(iso: $iso, englishName: $englishName, name: $name)';

  @override
  bool operator ==(covariant SelectableModel other) {
    if (identical(this, other)) return true;

    return other.iso == iso &&
        other.englishName == englishName &&
        other.name == name;
  }

  @override
  int get hashCode => iso.hashCode ^ englishName.hashCode ^ name.hashCode;
}
