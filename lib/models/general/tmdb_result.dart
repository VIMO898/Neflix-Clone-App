// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TmdbResult<T> {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<T> results;

  TmdbResult({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) toMapT) {
    return {
      'page': page,
      'total_pages': totalPages,
      'total_results': totalResults,
      'results': results.map(toMapT).toList(),
    };
  }

  factory TmdbResult.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMapT,
  ) {
    return TmdbResult(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: List<Map<String, dynamic>>.from(map['results'])
          .map(fromMapT)
          .toList(),
    );
  }

  factory TmdbResult.fromJson(
    String source,
    T Function(Map<String, dynamic>) fromMapT,
  ) {
    return TmdbResult.fromMap(json.decode(source), fromMapT);
  }

  @override
  String toString() {
    return 'TmdbResult(page: $page, totalPages: $totalPages, totalResults: $totalResults, results: $results)';
  }

  TmdbResult<T> copyWith({
    int? page,
    int? totalPages,
    int? totalResults,
    List<T>? results,
  }) {
    return TmdbResult<T>(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }
}
