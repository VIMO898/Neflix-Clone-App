import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/enums.dart';
import '../../../providers/controllers/app_setting_controller_provider.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../../../utils/snackbar_helper.dart';
import 'setting_dialog.dart';
import 'setting_dialog_tile.dart';

class DefaultTvShowDialog extends ConsumerWidget {
  const DefaultTvShowDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultTvShowTabs = TvShowCategory.values;
    final appSettings = ref.read(appSettingControllerProvider);
    final currDefaultTvShowTab = appSettings.defaultTvShowTab;
    return SettingDialog(
      height: 410,
      title: 'Default TV Show Tab',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultTvShowTabs.length,
        itemBuilder: (context, index) {
          final currTab = defaultTvShowTabs[index].name.readable();
          final isLastItem = (defaultTvShowTabs.length - 1) == index;
          return SettingDialogTile.radio(
            title: currTab,
            radioValue: currTab,
            groupRadioValue: currDefaultTvShowTab.name.readable(),
            addBottomDivider: !isLastItem,
            onRadioChanged: (_) {
              ref
                  .read(appSettingControllerProvider.notifier)
                  .updateDefaultTvShowTab(defaultTvShowTabs[index]);
              NavHelper.pop(context);
              SnackBarHelper.show(
                context,
                'Default TV Show Tab changed successfully, but make sure to restart the app to see changes',
              );
            },
          );
        },
      ),
    );
  }
}
