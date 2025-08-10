import 'package:flutter/material.dart';

class MediaGalleryTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MediaGalleryTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return TabBar(
        dividerHeight: 0,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.center,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: textTheme.titleLarge
            ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(
            text: 'Videos',
          ),
          Tab(
            text: 'Images',
          )
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(30);
}
