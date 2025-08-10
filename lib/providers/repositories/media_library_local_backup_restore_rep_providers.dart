import 'package:app/constants/enums.dart';
import 'package:app/providers/repositories/already_watched_media_repo_provider.dart';
import 'package:app/providers/repositories/liked_media_repo_provider.dart';
import 'package:app/providers/repositories/media_watch_list_repo_provider.dart';
import 'package:app/repositories/media_library_local_backup_restore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteBackupRestoreRepoProvider = Provider((ref) {
  final repo = ref.watch(likedMediaRepoProvider);
  return MediaLibraryBackupRestoreRepository(
    mediaLibType: MediaLibraryType.favorites,
    repo: repo,
  );
});

final watchlistBackupRestoreRepoProvider = Provider((ref) {
  final repo = ref.watch(mediaWatchListRepoProvider);
  return MediaLibraryBackupRestoreRepository(
    mediaLibType: MediaLibraryType.watchlist,
    repo: repo,
  );
});

final alreadyWatchedlistBackupRestoreRepoProvider = Provider((ref) {
  final repo = ref.watch(alreadyWatchedMediaRepoProvider);
  return MediaLibraryBackupRestoreRepository(
    mediaLibType: MediaLibraryType.alreadyWatchedlist,
    repo: repo,
  );
});
