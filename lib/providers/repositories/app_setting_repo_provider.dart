import 'package:app/constants/hive_box_names.dart';
import 'package:app/repositories/app_setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final appSettingRepositoryProvider = Provider((ref) {
  final box = Hive.box(HiveBoxNames.appSettings);
  return AppSettingRepository(box);
});
