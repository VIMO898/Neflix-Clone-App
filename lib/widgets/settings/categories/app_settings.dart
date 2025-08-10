import 'dart:developer';
import 'package:app/constants/enums.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:app/providers/controllers/app_setting_controller_provider.dart';
import 'package:app/providers/controllers/theme_state_controller_provider.dart';
import 'package:app/screens/selectable_list_view_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/settings/categorized_settings.dart';
import 'package:app/widgets/settings/dialogs/default_home_screen_dialog.dart';
import 'package:app/widgets/settings/dialogs/default_movie_tab_dialog.dart';
import 'package:app/widgets/settings/dialogs/default_tv_show_dialog.dart';
import 'package:app/widgets/settings/dialogs/media_poster_size_dialog.dart';
import 'package:app/widgets/settings/dialogs/theme_mode_dialog.dart';
import 'package:app/widgets/settings/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings extends ConsumerWidget {
  const AppSettings({super.key});

  void _handleNotificationToggle(WidgetRef ref, bool isChecked) {
    ref
        .read(appSettingControllerProvider.notifier)
        .receiveNotifications(isChecked);
  }

  void _handleDisableSafeModeToggle(WidgetRef ref, bool isChecked) {
    ref.read(appSettingControllerProvider.notifier).disableSafeMode(isChecked);
  }

  @override
  Widget build(BuildContext context, ref) {
    final appSettings = ref.watch(appSettingControllerProvider);
    final themeState = ref.watch(themeStateControllerProvider);
    final themeMode = themeState.themeMode;
    final isDarkMode = themeMode == ThemeMode.dark;
    final isSystemThemeMode = themeState.useSystem;
    log(appSettings.toString());
    return CategorizedSettings(
      title: 'App Settings',
      tiles: [
        SettingTile(
          leadingIcon: Icons.contrast_outlined,
          title: 'Theme',
          subtitle: isSystemThemeMode
              ? 'System'
              : isDarkMode
              ? 'Dark'
              : 'Light',
          onTap: () => showDialog(
            context: context,
            builder: (context) => ThemeModeDialog(),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.language_outlined,
          title: 'Choose Preferred Language',
          subtitle: appSettings.preferredLanguage.englishName,
          onTap: () => NavHelper.push(
            context,
            SelectableListViewScreen(type: SelectableListViewType.language),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.travel_explore_outlined,
          title: 'Available Regions',
          subtitle: appSettings.region.englishName,
          onTap: () => NavHelper.push(
            context,
            SelectableListViewScreen(type: SelectableListViewType.region),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.home_outlined,
          title: 'Default Homepage',
          subtitle: appSettings.defaultHomeScreen.name.readable(),
          onTap: () => showDialog(
            context: context,
            builder: (context) => DefaultHomeScreenDialog(),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.local_movies_outlined,
          title: 'Default Movie Tab',
          subtitle: appSettings.defaultMovieTab.name.readable(),
          onTap: () => showDialog(
            context: context,
            builder: (context) => DefaultMovieTabDialog(),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.live_tv_outlined,
          title: 'Default TV Show Tab',
          subtitle: appSettings.defaultTvShowTab.name.readable(),
          onTap: () => showDialog(
            context: context,
            builder: (context) => DefaultTvShowDialog(),
          ),
        ),
        SettingTile(
          leadingIcon: Icons.photo_size_select_large_outlined,
          title: 'Media Poster Size',
          subtitle: appSettings.mediaPosterSize.name.readable(),
          onTap: () => showDialog(
            context: context,
            builder: (context) => MediaPosterSizeDialog(),
          ),
        ),
        SettingTile.checkbox(
          leadingIcon: Icons.notifications_active_outlined,
          title: 'Notifications',
          subtitle: 'Get notified for new releases, favorite shows, etc.',
          isChecked: appSettings.receiveNotifications,
          onCheckboxChanged: (checked) =>
              _handleNotificationToggle(ref, checked ?? false),
        ),
        SettingTile.checkbox(
          leadingIcon: Icons.shield_outlined,
          title: 'Disable Safe Mode',
          subtitle: 'Show adult content',
          isChecked: appSettings.disableSafeMode,
          onCheckboxChanged: (checked) =>
              _handleDisableSafeModeToggle(ref, checked ?? false),
        ),
      ],
    );
  }
}
