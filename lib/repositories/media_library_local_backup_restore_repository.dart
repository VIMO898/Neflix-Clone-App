import 'dart:developer';
import 'dart:io';
import 'package:app/models/general/media_state_model.dart';
import 'package:app/repositories/hive_media_repository.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:app/constants/enums.dart';

import '../exceptions/custom_exception.dart';

abstract class BaseMediaLibraryBackupRestoreRepository {
  Future<void> restoreMediaData();
  Future<void> backupMediaData();
}

class MediaLibraryBackupRestoreRepository
    implements BaseMediaLibraryBackupRestoreRepository {
  final BaseHiveMediaRepository repo;
  final MediaLibraryType mediaLibType;
  const MediaLibraryBackupRestoreRepository({
    required this.mediaLibType,
    required this.repo,
  });
  @override
  Future<void> backupMediaData() async {
    try {
      final directory = await path.getApplicationDocumentsDirectory();

      final file = File('${directory.path}/${mediaLibType.name}.txt');

      final mediaDataState = MediaStateModel(
        movies: repo.getMovies(),
        tvShows: repo.getTvShows(),
      );
      await file.writeAsString(mediaDataState.toJson());

      log('File saved at: ${file.path}');
    } catch (e) {
      log('Error writing file: $e');
      CustomException(message: 'Error backing up media data');
    }
  }

  @override
  Future<void> restoreMediaData() async {
    try {
      final directory = await path.getApplicationDocumentsDirectory();

      final file = File('${directory.path}/${mediaLibType.name}.txt');
      final fileExists = await file.exists();
      if (!fileExists) {
        throw CustomException(message: 'No file found to restore from');
      }

      final mediaDataAsJson = await file.readAsString();
      if (mediaDataAsJson.isEmpty) {
        throw CustomException(message: 'No data found over restore');
      }

      final mediaDataState = MediaStateModel.fromJson(mediaDataAsJson);

      // log(mediaDataState);
      await repo.addMovies(mediaDataState.movies);
      await repo.addTvShows(mediaDataState.tvShows);
    } catch (e) {
      log('Error reading file: $e');
      CustomException(message: 'Error restoring media data');
    }
  }
}
