import 'package:app/controllers/hive_media_controller.dart';
import 'package:app/models/general/media_state_model.dart';
import 'package:app/providers/repositories/media_watch_list_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaWatchListControllerProvider =
    StateNotifierProvider<HiveMediaController, MediaStateModel>((ref) {
  final repo = ref.watch(mediaWatchListRepoProvider);
  return HiveMediaController(repo);
});
