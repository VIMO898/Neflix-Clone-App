import 'package:app/controllers/hive_media_controller.dart';
import 'package:app/models/general/media_state_model.dart';
import 'package:app/providers/repositories/liked_media_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likedMediaControllerProvider =
    StateNotifierProvider<HiveMediaController, MediaStateModel>((ref) {
  final repo = ref.watch(likedMediaRepoProvider);
  return HiveMediaController(repo);
});
