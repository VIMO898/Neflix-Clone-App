import 'package:app/constants/enums.dart';
import 'package:app/models/general/media_state_model.dart';
import 'package:app/providers/controllers/already_watched_media_controller_provider.dart';
import 'package:app/providers/controllers/liked_media_controller_provider.dart';
import 'package:app/providers/controllers/media_watch_list_controller_provider.dart';
import 'package:app/providers/general/movie_genres_provider.dart';
import 'package:app/providers/general/tv_show_genres_provider.dart';
import 'package:app/utils/all_media_type_tile_list.dart';
import 'package:app/widgets/general/centered_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MediaLibraryScreen extends ConsumerStatefulWidget {
  final MediaLibraryType libraryType;
  const MediaLibraryScreen({super.key, required this.libraryType});

  @override
  ConsumerState<MediaLibraryScreen> createState() => _MediaLibraryScreenState();
}

class _MediaLibraryScreenState extends ConsumerState<MediaLibraryScreen> {
  Future<void> _handleMediaRefresh() async {
    switch (widget.libraryType) {
      case MediaLibraryType.favorites:
        ref.read(likedMediaControllerProvider.notifier).getMediaState();
      case MediaLibraryType.watchlist:
        ref.read(mediaWatchListControllerProvider.notifier).getMediaState();
      case MediaLibraryType.alreadyWatchedlist:
        ref
            .read(alreadyWatchedMediaControllerProvider.notifier)
            .getMediaState();
    }
  }

  @override
  Widget build(BuildContext context) {
    late MediaStateModel media;
    switch (widget.libraryType) {
      case MediaLibraryType.favorites:
        media = ref.watch(likedMediaControllerProvider);
      case MediaLibraryType.watchlist:
        media = ref.watch(mediaWatchListControllerProvider);
      case MediaLibraryType.alreadyWatchedlist:
        media = ref.watch(alreadyWatchedMediaControllerProvider);
    }
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: TabBar(
              dividerHeight: 0,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Movies', icon: Icon(Icons.movie)),
                Tab(text: 'Tv Shows', icon: Icon(Icons.tv)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            media.movies.isEmpty
                ? emptyListMessage[widget.libraryType]!
                : _buildMediaTileListView(
                    context,
                    ref,
                    AllMediaType.movies,
                    media.movies,
                  ),
            media.tvShows.isEmpty
                ? emptyListMessage[widget.libraryType]!
                : _buildMediaTileListView(
                    context,
                    ref,
                    AllMediaType.tvShows,
                    media.tvShows,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaTileListView(
    BuildContext context,
    WidgetRef ref,
    AllMediaType type,
    List<Object> media,
  ) {
    final movieGenres = ref.watch(movieGenresProvider);
    final tvShowGenres = ref.watch(tvShowGenresProvider);
    final tiles = allMediaTypeTileList(
      context,
      type: type,
      mediaList: media,
      movieGenres: movieGenres,
      tvShowGenres: tvShowGenres,
    );
    return RefreshIndicator(
      displacement: 10.0, // vertical position (default is 40)
      onRefresh: _handleMediaRefresh,
      child: ListView.builder(
        itemCount: media.length,
        itemBuilder: (context, index) {
          return tiles[index];
        },
      ),
    );
  }

  Map<MediaLibraryType, Widget> get emptyListMessage => {
    MediaLibraryType.favorites: CenteredMessage(
      icon: FontAwesomeIcons.thumbsUp,
      title: 'No Favourites Yet',
      subtitle: 'Love a movie or show? Tap the heart to keep it here.',
    ),
    MediaLibraryType.watchlist: CenteredMessage(
      icon: FontAwesomeIcons.bookmark,
      title: 'Your Watchlist is Empty',
      subtitle:
          'Add movies or shows you plan to watch. Start browsing and build your list!',
    ),
    MediaLibraryType.alreadyWatchedlist: CenteredMessage(
      icon: FontAwesomeIcons.circleCheck,
      title: 'Nothing Marked as Watched',
      subtitle:
          'Once you finish something, mark it as watched — and track your journey',
    ),
  };
}
