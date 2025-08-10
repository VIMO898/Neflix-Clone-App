import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductionCountryModel {
  final String iso31661;
  final String name;
  ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso_3166_1': iso31661,
      'name': name,
    };
  }

  factory ProductionCountryModel.fromMap(Map<String, dynamic> map) {
    return ProductionCountryModel(
      iso31661: map['iso_3166_1'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionCountryModel.fromJson(String source) =>
      ProductionCountryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionCountryModel(iso31661: $iso31661, name: $name)';
}
