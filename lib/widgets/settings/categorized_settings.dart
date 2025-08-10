import 'package:app/widgets/settings/setting_tile.dart';
import 'package:flutter/material.dart';

class CategorizedSettings extends StatelessWidget {
  final String title;
  final List<SettingTile> tiles;
  const CategorizedSettings({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 22, 10, 0),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        ...tiles,
      ],
    );
  }
}
