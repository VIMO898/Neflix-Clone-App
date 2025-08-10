import 'package:app/controllers/hive_media_controller.dart';
import 'package:app/models/general/media_state_model.dart';
import 'package:app/providers/repositories/already_watched_media_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alreadyWatchedMediaControllerProvider =
    StateNotifierProvider<HiveMediaController, MediaStateModel>((ref) {
      final repo = ref.watch(alreadyWatchedMediaRepoProvider);
      return HiveMediaController(repo);
    });
