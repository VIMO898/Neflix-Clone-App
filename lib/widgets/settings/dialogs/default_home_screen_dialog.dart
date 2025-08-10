import 'package:app/extensions/string_extension.dart';
import 'package:app/widgets/settings/dialogs/setting_dialog.dart';
import 'package:app/widgets/settings/dialogs/setting_dialog_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/enums.dart';
import '../../../providers/controllers/app_setting_controller_provider.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../../../utils/snackbar_helper.dart';

class DefaultHomeScreenDialog extends ConsumerWidget {
  const DefaultHomeScreenDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultHomeScreens = DefaultHomeScreen.values;
    final appSettings = ref.watch(appSettingControllerProvider);
    final currDefaultHomeScreen = appSettings.defaultHomeScreen;
    return SettingDialog(
      height: 280,
      title: 'Default Homepage',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultHomeScreens.length,
        itemBuilder: (context, index) {
          final currHomeScreen = defaultHomeScreens[index].name.readable();
          final isLastItem = (defaultHomeScreens.length - 1) == index;
          return SettingDialogTile.radio(
            title: currHomeScreen,
            radioValue: currHomeScreen,
            groupRadioValue: currDefaultHomeScreen.name.readable(),
            addBottomDivider: !isLastItem,
            onRadioChanged: (_) {
              ref
                  .read(appSettingControllerProvider.notifier)
                  .updateDefaultHomeScreen(defaultHomeScreens[index]);
              NavHelper.pop(context);
              SnackBarHelper.show(
                context,
                'Default Homepage changed successfully, but make sure to restart the app to see changes',
              );
            },
          );
        },
      ),
    );
  }
}
