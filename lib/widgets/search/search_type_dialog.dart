import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import '../../constants/enums.dart';
import '../settings/dialogs/setting_dialog.dart';
import '../settings/dialogs/setting_dialog_tile.dart';

class SearchTypeDialog extends StatelessWidget {
  final AllMediaType currSearchType;
  final void Function(String? updatedValue) onChanged;
  const SearchTypeDialog({
    super.key,
    required this.currSearchType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final searchTypes = AllMediaType.values;
    return SettingDialog(
      height: 280,
      title: 'Search By',
      child: ListView.builder(
        itemCount: searchTypes.length,
        itemBuilder: (context, index) {
          final type = searchTypes[index];
          final isLastItem = (searchTypes.length - 1) == index;
          return SettingDialogTile.radio(
            title: type.name.readable(),
            radioValue: type.name.readable(),
            addBottomDivider: !isLastItem,
            groupRadioValue: currSearchType.name.readable(),
            onRadioChanged: onChanged,
          );
        },
      ),
    );
  }
}
