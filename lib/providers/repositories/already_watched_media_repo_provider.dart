import 'package:app/providers/boxes/movie_watch_later_box_provider.dart';
import 'package:app/providers/boxes/tv_show_watch_later_box_provider.dart';
import 'package:app/repositories/already_watched_media.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alreadyWatchedMediaRepoProvider = Provider((ref) {
  final movieBox = ref.watch(movieWatchLaterBoxProvider);
  final tvShowBox = ref.watch(tvShowWatchLaterBoxProvider);
  return AlreadyWatchedMediaRepository(
    movieBox: movieBox,
    tvShowBox: tvShowBox,
  );
});
