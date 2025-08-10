import 'dart:convert';

import 'package:app/constants/enums.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MediaImageModel {
  final MediaImageType? type;
  final double aspectRatio;
  final int height;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;
  MediaImageModel({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
    this.type,
  });

  @override
  String toString() {
    return 'MediaImageModel(type: $type, aspectRatio: $aspectRatio, height: $height, iso6391: $iso6391, filePath: $filePath, voteAverage: $voteAverage, voteCount: $voteCount, width: $width)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aspect_ratio': aspectRatio,
      'height': height,
      'iso_639_1': iso6391,
      'file_path': filePath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'width': width,
    };
  }

  factory MediaImageModel.fromMap(Map<String, dynamic> map) {
    return MediaImageModel(
      aspectRatio: map['aspect_ratio'],
      height: map['height'],
      iso6391: map['iso_639_1'],
      filePath: map['file_path'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
      width: map['width'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaImageModel.fromJson(String source) =>
      MediaImageModel.fromMap(json.decode(source));

  MediaImageModel copyWith({
    MediaImageType? type,
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return MediaImageModel(
      type: type ?? this.type,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      height: height ?? this.height,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      width: width ?? this.width,
    );
  }
}
