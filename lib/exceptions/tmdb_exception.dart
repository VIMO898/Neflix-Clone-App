class TmdbException implements Exception {
  final bool success;
  final int? statusCode;
  final String? statusMessage;

  const TmdbException(
      {this.success = false, this.statusCode, this.statusMessage});

  @override
  String toString() {
    String result = 'TMDB Exception';
    if (statusMessage != null && statusMessage!.isNotEmpty) {
      return '$result: $statusMessage';
    }
    return result;
  }
}
