// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/constants/enums.dart';
import 'package:app/models/general/region_model.dart';
import 'package:app/models/general/spoken_language_model.dart';

class AppSettingModel {
  final SpokenLanguageModel preferredLanguage;
  final RegionModel region;
  final DefaultHomeScreen defaultHomeScreen;
  final MovieCategory defaultMovieTab;
  final TvShowCategory defaultTvShowTab;
  final MediaPosterSize mediaPosterSize;
  final bool receiveNotifications;
  final bool disableSafeMode;
  AppSettingModel({
    required this.preferredLanguage,
    required this.region,
    required this.defaultHomeScreen,
    required this.defaultMovieTab,
    required this.defaultTvShowTab,
    required this.mediaPosterSize,
    required this.receiveNotifications,
    required this.disableSafeMode,
  });

  @override
  String toString() {
    return 'AppSettingModel(preferredLanguage: $preferredLanguage, region: $region, defaultHomeScreen: $defaultHomeScreen, defaultMovieTab: $defaultMovieTab, defaultTvShowTab: $defaultTvShowTab, mediaPosterSize: $mediaPosterSize, receiveNotifications: $receiveNotifications, disableSafeMode: $disableSafeMode)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'preferred_language': preferredLanguage.toMap(),
      'region': region.toMap(),
      'default_home_Screen': defaultHomeScreen.name,
      'default_movie_tab': defaultMovieTab.name,
      'default_tv_show_tab': defaultTvShowTab.name,
      'media_poster_size': mediaPosterSize.name,
      'receive_notifications': receiveNotifications,
      'disable_safe_mode': disableSafeMode,
    };
  }

  factory AppSettingModel.fromMap(Map<String, dynamic> map) {
    return AppSettingModel(
      preferredLanguage: SpokenLanguageModel.fromMap(map['preferred_language']),
      region: RegionModel.fromMap(map['region']),
      defaultHomeScreen: DefaultHomeScreen.values
          .firstWhere((m) => m.name == map['default_home_Screen']),
      defaultMovieTab: MovieCategory.values
          .firstWhere((m) => m.name == map['default_movie_tab']),
      defaultTvShowTab: TvShowCategory.values
          .firstWhere((m) => m.name == map['default_tv_show_tab']),
      mediaPosterSize: MediaPosterSize.values
          .firstWhere((m) => m.name == map['media_poster_size']),
      receiveNotifications: map['receive_notifications'],
      disableSafeMode: map['disable_safe_mode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingModel.fromJson(String source) =>
      AppSettingModel.fromMap(json.decode(source));

  AppSettingModel copyWith({
    SpokenLanguageModel? preferredLanguage,
    RegionModel? region,
    DefaultHomeScreen? defaultHomeScreen,
    MovieCategory? defaultMovieTab,
    TvShowCategory? defaultTvShowTab,
    MediaPosterSize? mediaPosterSize,
    bool? receiveNotifications,
    bool? disableSafeMode,
  }) {
    return AppSettingModel(
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      region: region ?? this.region,
      defaultHomeScreen: defaultHomeScreen ?? this.defaultHomeScreen,
      defaultMovieTab: defaultMovieTab ?? this.defaultMovieTab,
      defaultTvShowTab: defaultTvShowTab ?? this.defaultTvShowTab,
      mediaPosterSize: mediaPosterSize ?? this.mediaPosterSize,
      receiveNotifications: receiveNotifications ?? this.receiveNotifications,
      disableSafeMode: disableSafeMode ?? this.disableSafeMode,
    );
  }
}
