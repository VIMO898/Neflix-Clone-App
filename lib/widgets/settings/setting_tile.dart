import 'package:flutter/material.dart';

enum SettingTileType { regular, checkbox, radio }

class SettingTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final String? trailingText;
  final Widget? trailingWidget;
  final bool addTopDivider;
  final bool addBottomDivider;
  final SettingTileType type;
  final VoidCallback? onTap;
  final bool? isChecked;
  final ValueChanged<bool?>? onCheckboxChanged;

  const SettingTile({
    super.key,
    required this.title,
    this.leadingIcon,
    this.subtitle,
    this.trailingText,
    this.trailingWidget,
    this.onTap,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.addTopDivider = false,
    this.addBottomDivider = true,
  }) : type = SettingTileType.regular,
       isChecked = null,
       onCheckboxChanged = null;

  const SettingTile.checkbox({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onCheckboxChanged,
    this.leadingIcon,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.addTopDivider = false,
    this.addBottomDivider = true,
  }) : type = SettingTileType.checkbox,
       trailingText = null,
       trailingWidget = null,
       onTap = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final dividerStyles = BorderSide(width: 0.7, color: Colors.grey);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: addTopDivider ? dividerStyles : BorderSide.none,
          bottom: addBottomDivider ? dividerStyles : BorderSide.none,
        ),
      ),
      child: ListTile(
        onTap:
            onTap ??
            () => onCheckboxChanged!(isChecked != null ? !isChecked! : false),
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        titleTextStyle:
            titleTextStyle ??
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        subtitleTextStyle: subtitleTextStyle ?? textTheme.bodyMedium,
        leading: leadingIcon != null ? Icon(leadingIcon, size: 28) : null,
        title: Text(title),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: Text(subtitle!),
              )
            : null,
        trailing: _buildTrailing(),
      ),
    );
  }

  Widget? _buildTrailing() {
    switch (type) {
      case SettingTileType.regular:
        return trailingText != null ? Text(trailingText!) : trailingWidget;
      case SettingTileType.checkbox:
        return Checkbox(value: isChecked, onChanged: onCheckboxChanged);
      case SettingTileType.radio:
        return null;
    }
  }
}
