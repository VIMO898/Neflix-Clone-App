import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/enums.dart';
import '../../../providers/controllers/app_setting_controller_provider.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../../../utils/snackbar_helper.dart';
import 'setting_dialog.dart';
import 'setting_dialog_tile.dart';

class DefaultMovieTabDialog extends ConsumerWidget {
  const DefaultMovieTabDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultMovieTabs = MovieCategory.values;
    final appSettings = ref.read(appSettingControllerProvider);
    final currDefaultMovieTab = appSettings.defaultMovieTab;
    return SettingDialog(
      height: 410,
      title: 'Default Movie Tab',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultMovieTabs.length,
        itemBuilder: (context, index) {
          final currTab = defaultMovieTabs[index].name.readable();
          final isLastItem = (defaultMovieTabs.length - 1) == index;
          return SettingDialogTile.radio(
            title: currTab,
            radioValue: currTab,
            groupRadioValue: currDefaultMovieTab.name.readable(),
            addBottomDivider: !isLastItem,
            onRadioChanged: (_) {
              ref
                  .read(appSettingControllerProvider.notifier)
                  .updateDefaultMovieTab(defaultMovieTabs[index]);
              NavHelper.pop(context);
              SnackBarHelper.show(
                context,
                'Default Movie Tab changed successfully, but make sure to restart the app to see changes',
              );
            },
          );
        },
      ),
    );
  }
}
