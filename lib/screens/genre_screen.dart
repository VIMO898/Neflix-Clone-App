import 'package:app/constants/enums.dart';
import 'package:app/models/general/genre_model.dart';
import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/providers/general/movie_genres_provider.dart';
import 'package:app/providers/general/tv_show_genres_provider.dart';
import 'package:app/screens/media_grid_view_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  void _handleMediaSearchByGenre(
    BuildContext context, {
    required AllMediaType mediaType,
    required GenreModel genre,
  }) {
    final now = DateTime.now();
    final screen = MediaGridViewScreen.withScaffold(
      appbarTitle: genre.name,
      type: mediaType,
      filters: MediaDiscoveryFilterModel(
        genres: [genre],
        releaseYearRange: (from: null, to: now.year),
        sortBy: SortBy.popularity,
        sortOrder: SortOrder.descending,
      ),
    );
    NavHelper.push(context, screen);
  }

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    final movieGenres = ref.watch(movieGenresProvider);
    final tvShowGenres = ref.watch(tvShowGenresProvider);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          // preferredSize: Size.fromHeight(50),
          bottom: TabBar(
            dividerHeight: 0,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.center,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Movie', icon: Icon(Icons.movie)),
              Tab(text: 'Tv Show', icon: Icon(Icons.tv)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGenreListView(
              theme,
              movieGenres,
              (genreId) => _handleMediaSearchByGenre(
                context,
                mediaType: AllMediaType.movies,
                genre: movieGenres.firstWhere((g) => g.id == genreId),
              ),
            ),
            _buildGenreListView(
              theme,
              tvShowGenres,
              (genreId) => _handleMediaSearchByGenre(
                context,
                mediaType: AllMediaType.tvShows,
                genre: tvShowGenres.firstWhere((g) => g.id == genreId),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreListView(
    ThemeData theme,
    List<GenreModel> genres,
    void Function(int genreId) onTap,
  ) {
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return _buildGenreCard(textTheme, genre, onTap);
        },
      ),
    );
  }

  Padding _buildGenreCard(
    TextTheme textTheme,
    GenreModel genre,
    void Function(int genreId) onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onTap(genre.id),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          height: 230,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(genre.localImgSrc!),
              fit: BoxFit.cover,
              opacity: 0.6,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            genre.name,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ListTile(
//           onTap: () => onTap(genre.id),
//           shape: Border(
//               bottom: BorderSide(color: colorScheme.secondary, width: 0.2)),
//           title: Text(
//             genre.name,
//             style: textTheme.titleLarge,
//           ),
//         )
