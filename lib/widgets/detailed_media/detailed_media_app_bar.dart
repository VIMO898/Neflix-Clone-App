import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';
import '../../utils/navigator_shortcuts.dart';

class DetailedMediaAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final ScrollController scrollController;
  const DetailedMediaAppBar({
    super.key,
    required this.title,
    required this.scrollController,
  });

  @override
  State<DetailedMediaAppBar> createState() => _DetailedMediaAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _DetailedMediaAppBarState extends State<DetailedMediaAppBar> {
  double _appbarTitleOpacity = 0.0;

  void _onScroll() {
    final positionPixels = widget.scrollController.position.pixels;
    if (positionPixels > 320) {
      if (_appbarTitleOpacity != 1.0) setState(() => _appbarTitleOpacity = 1.0);
    } else {
      setState(() => _appbarTitleOpacity = positionPixels / 320);
    }
  }

  @override
  void initState() {
    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return AppBar(
      leading: IconButton(
        onPressed: () => NavHelper.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: _buildAppbarTitle(textTheme, colorScheme),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => NavHelper.push(context, SearchScreen()),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Opacity _buildAppbarTitle(TextTheme textTheme, ColorScheme colorScheme) {
    return Opacity(
      opacity: _appbarTitleOpacity,
      child: Text(
        widget.title,
        style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
