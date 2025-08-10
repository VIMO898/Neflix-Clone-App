import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class KeywordModel {
  final int id;
  final String name;
  KeywordModel({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'KeywordModel(id: $id, name: $name)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory KeywordModel.fromMap(Map<String, dynamic> map) {
    return KeywordModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeywordModel.fromJson(String source) =>
      KeywordModel.fromMap(json.decode(source));
}
