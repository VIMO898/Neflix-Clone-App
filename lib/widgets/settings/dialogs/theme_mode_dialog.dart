import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/controllers/theme_state_controller_provider.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../../../utils/snackbar_helper.dart';
import 'setting_dialog.dart';
import 'setting_dialog_tile.dart';

class ThemeModeDialog extends ConsumerWidget {
  const ThemeModeDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeStateControllerProvider);
    final themeModeValues = ThemeMode.values;
    final currThemeMode = themeState.useSystem
        ? ThemeMode.system
        : themeState.themeMode;
    return SettingDialog(
      height: 280,
      title: 'Theme Mode',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: themeModeValues.length,
        itemBuilder: (context, index) {
          final currMode = themeModeValues[index].name.readable();
          final isLastItem = (themeModeValues.length - 1) == index;
          return SettingDialogTile.radio(
            title: currMode,
            radioValue: currMode,
            groupRadioValue: currThemeMode.name.readable(),
            addBottomDivider: !isLastItem,
            onRadioChanged: (_) {
              ref
                  .read(themeStateControllerProvider.notifier)
                  .setThemeMode(themeModeValues[index]);
              NavHelper.pop(context);
              SnackBarHelper.show(
                context,
                'Default Theme Mode changed successfully.',
              );
            },
          );
        },
      ),
    );
  }
}
