import 'package:flutter/material.dart';

enum SettingDialogType { regular, radio }

class SettingDialogTile extends StatelessWidget {
  final SettingDialogType type;
  final String title;
  final String? subtitle;
  final bool? selected;
  final VoidCallback? onTap;

  final bool addBottomDivider;
  final bool addTopDivider;

  final String? radioValue;
  final String? groupRadioValue;
  final ValueChanged<String?>? onRadioChanged;

  const SettingDialogTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.addTopDivider = false,
    this.addBottomDivider = true,
  }) : type = SettingDialogType.regular,
       radioValue = null,
       groupRadioValue = null,
       onRadioChanged = null;

  const SettingDialogTile.radio({
    super.key,
    required this.title,
    required this.radioValue,
    required this.groupRadioValue,
    required this.onRadioChanged,
    this.addTopDivider = false,
    this.addBottomDivider = true,
  }) : type = SettingDialogType.radio,
       subtitle = null,
       onTap = null,
       selected = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    final dividerStyles = BorderSide(width: 0.7, color: Colors.grey);
    final isSelectedAndNonNullable = selected != null && selected!;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: addTopDivider ? dividerStyles : BorderSide.none,
          bottom: addBottomDivider ? dividerStyles : BorderSide.none,
        ),
      ),
      child: ListTile(
        onTap: onTap ?? () => onRadioChanged!(radioValue),
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
        leading: type == SettingDialogType.radio
            ? Transform.scale(
                scale: 1.15,
                child: Radio<String>(
                  value: radioValue!,
                  groupValue: groupRadioValue,
                  onChanged: onRadioChanged,
                ),
              )
            : null,
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: isSelectedAndNonNullable ? primaryColor : null,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: isSelectedAndNonNullable ? primaryColor : null,
                ),
              )
            : null,
        trailing: isSelectedAndNonNullable ? Icon(Icons.done) : null,
      ),
    );
  }
}
