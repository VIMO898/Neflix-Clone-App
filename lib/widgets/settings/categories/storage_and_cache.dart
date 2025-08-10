import 'package:app/utils/snackbar_helper.dart';
import 'package:app/widgets/settings/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import '../../../providers/repositories/media_library_local_backup_restore_rep_providers.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../categorized_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageAndCache extends ConsumerStatefulWidget {
  const StorageAndCache({super.key});

  @override
  ConsumerState<StorageAndCache> createState() => _StorageAndCacheState();
}

class _StorageAndCacheState extends ConsumerState<StorageAndCache> {
  String? _applicationDocumentDirectory;
  @override
  void initState() {
    super.initState();
    _handleSetApplicationDocDir();
  }

  void _handleSetApplicationDocDir() async {
    final dir = await path.getApplicationDocumentsDirectory();
    _applicationDocumentDirectory = dir.path;
    setState(() {});
  }

  void _openClearSearchHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 24.0,
        ),
        title: Text('Do you want to clear history search?'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          TextButton(
            onPressed: () => NavHelper.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement clearing search history
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }

  void handleClearCache(BuildContext context) async {
    // TODO: Implement clearing cache
    await Future.delayed(const Duration(milliseconds: 800));
    SnackBarHelper.show(context, 'Cached data of our App has been wipped out');
  }

  @override
  Widget build(BuildContext context) {
    // log((await path.getApplicationDocumentsDirectory()).toString());
    final path = _applicationDocumentDirectory;
    final favouriteRepo = ref.watch(favoriteBackupRestoreRepoProvider);
    final watchlistRepo = ref.watch(watchlistBackupRestoreRepoProvider);
    final alreadyWatchedlist = ref.watch(
      alreadyWatchedlistBackupRestoreRepoProvider,
    );
    return CategorizedSettings(
      title: 'Storage & Cache',
      tiles: [
        SettingTile(
          leadingIcon: Icons.delete_sweep_outlined,
          title: 'Clear Cache',
          subtitle: 'Clear locally cached images or API data',
          onTap: () => handleClearCache(context),
        ),
        SettingTile(
          leadingIcon: Icons.history_toggle_off_outlined,
          title: 'Clear Search History',
          onTap: () => _openClearSearchHistoryDialog(context),
        ),
        SettingTile(
          leadingIcon: Icons.cloud_upload_outlined,
          title: 'Backup Watchlist',
          subtitle: 'Sync to $path/watchlist.txt',
          onTap: () async {
            try {
              await watchlistRepo.backupMediaData();
              SnackBarHelper.show(
                context,
                'Backed up Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not back up Watchlist in local storage!',
              );
            }
          },
        ),
        SettingTile(
          leadingIcon: Icons.cloud_download_outlined,
          title: 'Restore Watchlist',
          subtitle: 'Restore from $path/watchlist.txt',
          onTap: () async {
            try {
              await watchlistRepo.restoreMediaData();
              SnackBarHelper.show(
                context,
                'Restored Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not restore Watchlist in local storage!',
              );
            }
          },
        ),
        SettingTile(
          leadingIcon: Icons.cloud_upload_outlined,
          title: 'Backup Favoritelist',
          subtitle: 'Sync to $path/favorites.txt',
          onTap: () async {
            try {
              await favouriteRepo.backupMediaData();
              SnackBarHelper.show(
                context,
                'Restored Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not restore Watchlist in local storage!',
              );
            }
          },
        ),
        SettingTile(
          leadingIcon: Icons.cloud_download_outlined,
          title: 'Restore Favoritelist',
          subtitle: 'Restore from $path/favorites.txt',
          onTap: () async {
            try {
              await favouriteRepo.restoreMediaData();
              SnackBarHelper.show(
                context,
                'Restored Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not restore Watchlist in local storage!',
              );
            }
          },
        ),
        SettingTile(
          leadingIcon: Icons.cloud_upload_outlined,
          title: 'Backup Watchedlist',
          subtitle: 'Sync to $path/watchedlist.txt',

          onTap: () async {
            try {
              await alreadyWatchedlist.backupMediaData();
              SnackBarHelper.show(
                context,
                'Restored Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not restore Watchlist in local storage!',
              );
            }
          },
        ),
        SettingTile(
          leadingIcon: Icons.cloud_download_outlined,
          title: 'Restore WatchedList',
          subtitle: 'Restore from $path/watchedlist.txt',

          onTap: () async {
            try {
              await alreadyWatchedlist.restoreMediaData();
              SnackBarHelper.show(
                context,
                'Restored Watchlist in local storage successfully!',
              );
            } catch (_) {
              SnackBarHelper.show(
                context,
                'Could not restore Watchlist in local storage!',
              );
            }
          },
        ),
      ],
    );
  }
}
