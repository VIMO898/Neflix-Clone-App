import 'package:app/providers/repositories/app_setting_repo_provider.dart';
import 'package:app/repositories/tmdb_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tmdbRepoProvider = Provider((ref) {
  final appSettingRepo = ref.watch(appSettingRepositoryProvider);
  return TmdbRepository(appSettingRepo: appSettingRepo);
});
