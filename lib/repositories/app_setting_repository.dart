import 'package:app/models/general/app_setting_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseAppSettingRepository {
  AppSettingModel? getAppSettings();
  Future<void> updateAppSettings(AppSettingModel settings);
}

class AppSettingRepository implements BaseAppSettingRepository {
  final Box box;
  const AppSettingRepository(this.box);

  String get appSettingKey => 'appSettings';
  @override
  AppSettingModel? getAppSettings() {
    final appSettingJson = box.get(appSettingKey);
    if (appSettingJson == null) return null;
    return AppSettingModel.fromJson(appSettingJson);
  }

  @override
  Future<void> updateAppSettings(AppSettingModel settings) {
    return box.put(
      appSettingKey,
      settings.toJson(),
    );
  }
}
