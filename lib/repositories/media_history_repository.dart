import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/repositories/hive_media_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MediaHistoryRepository extends HiveMediaRepository {
  final Box<MovieOverviewModel> historyMovieBox;
  final Box<TvShowOverviewModel> historyTvShowBox;
  const MediaHistoryRepository(
      {required this.historyMovieBox, required this.historyTvShowBox})
      : super(movieBox: historyMovieBox, tvShowBox: historyTvShowBox);
}
