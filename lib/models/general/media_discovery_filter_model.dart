// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/models/general/keyword_model.dart';

import '../../constants/enums.dart';
import 'genre_model.dart';

class MediaDiscoveryFilterModel {
  final List<GenreModel>? genres;
  final List<KeywordModel>? keywords;
  final ({double? min, double? max})? ratings;
  final ({int? min, int? max})? voteCount;
  final ({int? from, int? to})? releaseYearRange;
  final ({int? min, int? max})? runtimeRange;
  final SortBy? sortBy;
  final SortOrder? sortOrder;
  final String? withOriginalLanguage;
  final String? withOriginCountry;
  final bool? includeAdult;

  const MediaDiscoveryFilterModel({
    this.genres,
    this.keywords,
    this.ratings,
    this.releaseYearRange,
    this.runtimeRange,
    this.sortBy,
    this.sortOrder,
    this.voteCount,
    this.withOriginCountry,
    this.withOriginalLanguage,
    this.includeAdult,
  });

  @override
  String toString() {
    return 'ExploreMediaFormDataModel(genres: $genres, sortBy: $sortBy, sortOrder: $sortOrder, voteCount: $voteCount, withOriginCountry: $withOriginCountry, withOriginalLanguage: $withOriginalLanguage, includeAdult: $includeAdult, keywords: $keywords)';
  }
}
