import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FlatrateModel {
  final String? logoPath;
  final int providerId;
  final String providerName;
  final int displayPriority;

  const FlatrateModel(
      {required this.logoPath,
      required this.providerId,
      required this.providerName,
      required this.displayPriority});

  @override
  String toString() {
    return 'FlatrateModel(logoPath: $logoPath, providerId: $providerId, providerName: $providerName, displayPriority: $displayPriority)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo_path': logoPath,
      'provider_id': providerId,
      'provider_name': providerName,
      'display_priority': displayPriority,
    };
  }

  factory FlatrateModel.fromMap(Map<String, dynamic> map) {
    return FlatrateModel(
      logoPath: map['logo_path'],
      providerId: map['provider_id'],
      providerName: map['provider_name'],
      displayPriority: map['display_priority'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlatrateModel.fromJson(String source) =>
      FlatrateModel.fromMap(json.decode(source));
}
