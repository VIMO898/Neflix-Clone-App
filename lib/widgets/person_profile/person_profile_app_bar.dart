import 'package:flutter/material.dart';

import '../../models/people/person_details_model.dart';
import '../../utils/navigator_shortcuts.dart';

class PersonProfileAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;
  final PersonDetailsModel? personDetails;
  const PersonProfileAppBar({
    super.key,
    required this.scrollController,
    required this.personDetails,
  });

  @override
  State<PersonProfileAppBar> createState() => _PersonProfileAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight + 6);
}

class _PersonProfileAppBarState extends State<PersonProfileAppBar> {
  double _appbarContentOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final scrollPositionPixels = widget.scrollController.position.pixels;
    if (scrollPositionPixels > 300) {
      if (widget.personDetails != null && _appbarContentOpacity != 1.0) {
        setState(() => _appbarContentOpacity = 1.0);
      }
    } else {
      setState(() => _appbarContentOpacity = scrollPositionPixels / 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => NavHelper.pop(context),
        icon: Icon(Icons.arrow_back),
      ),
      titleSpacing: 4,
      title: _buildAppBarContent(),
    );
  }

  Widget? _buildAppBarContent() {
    final personDetails = widget.personDetails;
    return personDetails != null
        ? Opacity(
            opacity: _appbarContentOpacity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (personDetails.profilePath != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://image.tmdb.org/t/p/w185/${personDetails.profilePath}',
                      ),
                    ),
                  ),
                Text(personDetails.name),
              ],
            ),
          )
        : null;
  }
}
