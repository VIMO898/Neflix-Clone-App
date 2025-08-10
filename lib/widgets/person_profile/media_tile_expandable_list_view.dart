import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../providers/general/movie_genres_provider.dart';
import '../../providers/general/tv_show_genres_provider.dart';
import '../../utils/all_media_type_tile_list.dart';
import '../detailed_media/media_heading_text.dart';
import '../general/media_tile.dart';

class MediaTileExpandableListView extends ConsumerStatefulWidget {
  const MediaTileExpandableListView({
    super.key,
    required this.type,
    required this.title,
    required this.mediaList,
  });
  final AllMediaType type;
  final String title;
  final List<Object> mediaList;

  @override
  ConsumerState<MediaTileExpandableListView> createState() =>
      _MediaTileExpandableListViewState();
}

class _MediaTileExpandableListViewState
    extends ConsumerState<MediaTileExpandableListView> {
  bool _isExpanded = false;

  void _handleToggleListExpanded() {
    _isExpanded = !_isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final movieGenres = ref.watch(movieGenresProvider);
    final tvShowGenres = ref.watch(tvShowGenresProvider);
    final initialTileDisplayCount = 5;
    final mediaTiles = allMediaTypeTileList(context,
        type: widget.type,
        mediaList: widget.mediaList,
        movieGenres: movieGenres,
        tvShowGenres: tvShowGenres);
    final mediaTileCount = _isExpanded
        ? mediaTiles.length
        : mediaTiles.take(initialTileDisplayCount).length;

    return SizedBox(
      height: 106 + (mediaTileCount * 121),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MediaHeadingText(widget.title,
            padding: const EdgeInsets.only(top: 18, bottom: 4)),
        Expanded(child: _buildMediaTiles(mediaTileCount, mediaTiles)),
        if (widget.mediaList.length > 5)
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: TextButton.icon(
                  onPressed: _handleToggleListExpanded,
                  label: Text(_isExpanded ? 'Less' : 'More'),
                  icon: Icon(
                      _isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                      color: primaryColor))),
      ]),
    );
  }

  Widget _buildMediaTiles(int mediaTileCount, List<MediaTile> mediaTiles) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mediaTileCount,
      itemBuilder: (context, index) {
        return mediaTiles[index];
      },
    );
  }
}
