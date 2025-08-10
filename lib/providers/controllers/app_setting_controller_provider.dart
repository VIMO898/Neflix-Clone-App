import 'package:app/controllers/app_setting_controller.dart';
import 'package:app/models/general/app_setting_model.dart';
import 'package:app/providers/repositories/app_setting_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingControllerProvider =
    StateNotifierProvider<AppSettingController, AppSettingModel>((ref) {
  final repo = ref.watch(appSettingRepositoryProvider);
  return AppSettingController(repo);
});
