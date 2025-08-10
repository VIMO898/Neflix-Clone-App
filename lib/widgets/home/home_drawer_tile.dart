import 'package:flutter/material.dart';

class HomeDrawerTile extends StatelessWidget {
  const HomeDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final isFontAwesomeIcon = icon.fontPackage == 'font_awesome_flutter';
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          size: isFontAwesomeIcon ? 20 : 26,
          color: isSelected ? primaryColor : null,
        ),
        horizontalTitleGap: 18,
        contentPadding: EdgeInsets.only(left: 30),
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            // fontSize: 20,
            color: isSelected ? primaryColor : null,
          ),
        ),
      ),
    );
  }
}
