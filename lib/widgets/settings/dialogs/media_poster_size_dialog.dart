import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/enums.dart';
import '../../../providers/controllers/app_setting_controller_provider.dart';
import '../../../utils/navigator_shortcuts.dart';
import '../../../utils/snackbar_helper.dart';
import 'setting_dialog.dart';
import 'setting_dialog_tile.dart';

class MediaPosterSizeDialog extends ConsumerWidget {
  const MediaPosterSizeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaPosterSizes = MediaPosterSize.values;
    final appSettings = ref.read(appSettingControllerProvider);
    final currMediaPosterSize = appSettings.mediaPosterSize;
    return SettingDialog(
      height: 280,
      title: 'Media Poster Size',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mediaPosterSizes.length,
        itemBuilder: (context, index) {
          final mps = mediaPosterSizes[index].name.readable();
          final isLastItem = (mediaPosterSizes.length - 1) == index;
          return SettingDialogTile.radio(
            title: mps,
            radioValue: mps,
            groupRadioValue: currMediaPosterSize.name.readable(),
            addBottomDivider: !isLastItem,
            onRadioChanged: (_) {
              ref
                  .read(appSettingControllerProvider.notifier)
                  .updateMediaPosterSize(mediaPosterSizes[index]);
              NavHelper.pop(context);
              SnackBarHelper.show(
                context,
                'Media Poster Size changed successfully, but make sure to restart the app to see changes',
              );
            },
          );
        },
      ),
    );
  }
}
