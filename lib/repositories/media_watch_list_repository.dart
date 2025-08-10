import 'package:hive_flutter/adapters.dart';

import 'hive_media_repository.dart';

class MediaWatchListRepository extends HiveMediaRepository {
  final Box movieWatchListBox;
  final Box tvShowWatchListBox;
  MediaWatchListRepository(
      {required this.movieWatchListBox, required this.tvShowWatchListBox})
      : super(movieBox: movieWatchListBox, tvShowBox: tvShowWatchListBox);
}
