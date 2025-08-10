import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductionCompanyModel {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanyModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  factory ProductionCompanyModel.fromMap(Map<String, dynamic> map) {
    return ProductionCompanyModel(
      id: map['id'],
      logoPath: map['logo_path'],
      name: map['name'],
      originCountry: map['origin_country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionCompanyModel.fromJson(String source) =>
      ProductionCompanyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionCompanyModel(id: $id, logoPath: $logoPath, name: $name, originCountry: $originCountry)';
  }
}
