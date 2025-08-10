// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/constants/enums.dart';
import 'package:app/constants/map_constants.dart';

class MediaVideoModel {
  final String id;
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final MediaVideoType type;
  final bool official;
  final DateTime publishedAt;
  MediaVideoModel({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  @override
  String toString() {
    return 'MediaVideoModel(id: $id, iso6391: $iso6391, iso31661: $iso31661, name: $name, key: $key, site: $site, type: $type, size: $size, official: $official, publishedAt: $publishedAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'iso_639_1': iso6391,
      'iso_3166_1': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': mediaVideoTypeToString[type],
      'official': official,
      'published_at': publishedAt.toIso8601String(),
    };
  }

  factory MediaVideoModel.fromMap(Map<String, dynamic> map) {
    return MediaVideoModel(
      id: map['id'],
      iso6391: map['iso_639_1'],
      iso31661: map['iso_3166_1'],
      name: map['name'],
      key: map['key'],
      site: map['site'],
      size: map['size'],
      type: stringToMediaVideoType[map['type']] as MediaVideoType,
      official: map['official'],
      publishedAt: DateTime.parse(map['published_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaVideoModel.fromJson(String source) =>
      MediaVideoModel.fromMap(json.decode(source));
}
