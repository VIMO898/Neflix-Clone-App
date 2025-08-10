import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ExternalLinksModel {
  final int id;
  final String? freebaseMid;
  final String? freebaseId;
  final String? imdbId;
  final int? tvrageId;
  final String? wikidataId;
  final String? facebookId;
  final String? instagramId;
  final String? tiktokId;
  final String? twitterId;
  final String? youtubeId;
  ExternalLinksModel({
    required this.id,
    this.freebaseMid,
    this.freebaseId,
    this.imdbId,
    this.tvrageId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.tiktokId,
    this.twitterId,
    this.youtubeId,
  });

  @override
  String toString() {
    return 'ExternalLinksModel(id: $id, freebaseMid: $freebaseMid, freebaseId: $freebaseId, imdbId: $imdbId, tvrageId: $tvrageId, wikidataId: $wikidataId, facebookId: $facebookId, instagramId: $instagramId, tiktokId: $tiktokId, twitterId: $twitterId, youtubeId: $youtubeId)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'freebase_mid': freebaseMid,
      'freebase_id': freebaseId,
      'imdb_id': imdbId,
      'tvrage_id': tvrageId,
      'wikidata_id': wikidataId,
      'facebook_id': facebookId,
      'instagram_id': instagramId,
      'tiktok_id': tiktokId,
      'twitter_id': twitterId,
      'youtube_id': youtubeId,
    };
  }

  factory ExternalLinksModel.fromMap(Map<String, dynamic> map) {
    return ExternalLinksModel(
      id: map['id'],
      freebaseMid: map['freebase_mid'],
      freebaseId: map['freebase_id'],
      imdbId: map['imdb_id'],
      tvrageId: map['tvrage_id'],
      wikidataId: map['wikidata_id'],
      facebookId: map['facebook_id'],
      instagramId: map['instagram_id'],
      tiktokId: map['tiktok_id'],
      twitterId: map['twitter_id'],
      youtubeId: map['youtube_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalLinksModel.fromJson(String source) =>
      ExternalLinksModel.fromMap(json.decode(source));
}
