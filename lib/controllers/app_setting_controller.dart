import 'package:app/constants/enums.dart';
import 'package:app/models/general/app_setting_model.dart';
import 'package:app/models/general/region_model.dart';
import 'package:app/models/general/spoken_language_model.dart';
import 'package:app/repositories/app_setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingController extends StateNotifier<AppSettingModel> {
  final BaseAppSettingRepository repo;
  AppSettingController(this.repo) : super(defaultAppSettings) {
    _initializeState();
  }

  void _initializeState() {
    final savedAppSettings = repo.getAppSettings();
    if (savedAppSettings != null) {
      state = savedAppSettings;
    } else {
      state = defaultAppSettings;
    }
  }

  Future<void> _updateAppSettings(AppSettingModel updatedAppSettings) async {
    await repo.updateAppSettings(updatedAppSettings);
    state = updatedAppSettings;
  }

  Future<void> updatePreferredLanguage(SpokenLanguageModel language) =>
      _updateAppSettings(state.copyWith(preferredLanguage: language));

  Future<void> updateRegion(RegionModel region) =>
      _updateAppSettings(state.copyWith(region: region));

  Future<void> updateDefaultHomeScreen(DefaultHomeScreen defaultHomeScreen) =>
      _updateAppSettings(state.copyWith(defaultHomeScreen: defaultHomeScreen));

  Future<void> updateDefaultMovieTab(MovieCategory defaultMovieTab) =>
      _updateAppSettings(state.copyWith(defaultMovieTab: defaultMovieTab));

  Future<void> updateDefaultTvShowTab(TvShowCategory defaultTvShowTab) =>
      _updateAppSettings(state.copyWith(defaultTvShowTab: defaultTvShowTab));

  Future<void> updateMediaPosterSize(MediaPosterSize mediaPosterSize) =>
      _updateAppSettings(state.copyWith(mediaPosterSize: mediaPosterSize));

  Future<void> receiveNotifications(bool getNotified) =>
      _updateAppSettings(state.copyWith(receiveNotifications: getNotified));

  Future<void> disableSafeMode(bool disabled) =>
      _updateAppSettings(state.copyWith(disableSafeMode: disabled));
}

final defaultAppSettings = AppSettingModel(
    preferredLanguage: SpokenLanguageModel(
        englishName: 'English', iso6391: 'en', name: 'English'),
    region: RegionModel(
        iso31661: "US",
        englishName: "United States of America",
        nativeName: "United States"),
    defaultHomeScreen: DefaultHomeScreen.movies,
    defaultMovieTab: MovieCategory.popular,
    defaultTvShowTab: TvShowCategory.popular,
    mediaPosterSize: MediaPosterSize.small,
    receiveNotifications: false,
    disableSafeMode: false);
