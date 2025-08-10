import 'package:app/providers/boxes/tv_show_watch_list_box_provider.dart';
import 'package:app/repositories/media_watch_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../boxes/movie_watch_list_box_provider.dart';

final mediaWatchListRepoProvider = Provider((ref) {
  final movieWatchListBox = ref.watch(movieWatchListBoxProvider);
  final tvShowWatchListBox = ref.watch(tvShowWatchListBoxProvider);
  return MediaWatchListRepository(
      movieWatchListBox: movieWatchListBox,
      tvShowWatchListBox: tvShowWatchListBox);
});
