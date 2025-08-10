import 'package:app/constants/hive_box_names.dart';
import 'package:app/providers/controllers/theme_state_controller_provider.dart';
import 'package:app/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final appDocDir = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.openBox(HiveBoxNames.themeState, path: appDocDir.path);
  final appSettingBox = await Hive.openBox(
    HiveBoxNames.appSettings,
    path: appDocDir.path,
  );
  await Hive.openBox(
    HiveBoxNames.movieWatchList,
    path: '${appDocDir.path}/media_watchlist',
  );
  await Hive.openBox(
    HiveBoxNames.tvShowWatchList,
    path: '${appDocDir.path}/media_watchlist',
  );
  await Hive.openBox(
    HiveBoxNames.alreadyWatchedMovie,
    path: '${appDocDir.path}/already_watched_media',
  );
  await Hive.openBox(
    HiveBoxNames.alreadyWatchedTvShow,
    path: '${appDocDir.path}/already_watched_media',
  );
  await Hive.openBox(
    HiveBoxNames.likedMovies,
    path: '${appDocDir.path}/liked_media',
  );
  await Hive.openBox(
    HiveBoxNames.likedTvShows,
    path: '${appDocDir.path}/liked_media',
  );

  // final repo = TmdbRepository(
  //   appSettingRepo: AppSettingRepository(appSettingBox),
  // );
  // final mediaVideos =
  //     await repo.getMediaVideos(type: ExploreMediaType.movies, id: 60735);
  // log(mediaVideos.toString());

  // final mediaId = 1022787;
  // final mediaType = ExploreMediaType.movies;
  // final movieDetails = await repo.getMovieDetails(mediaId);
  // final credits = await repo.getMediaCredits(type: mediaType, id: mediaId);
  // final images = await repo.getMediaImages(type: mediaType, id: mediaId);
  // final videos = await repo.getMediaVideos(type: mediaType, id: mediaId);
  // final similar = await repo.getSimilarMovies(mediaId);
  // final recommendations = await repo.getMovieRecommendations(mediaId);
  // final watchProviders = await repo.getWatchProvider(
  //   type: mediaType,
  //   mediaId: 1323784,
  // );
  // final personDetails = await repo.getPersonDetails(3492070);
  // final episodes = await repo.getTvShowSeasonEpisodes(
  //   tvShowId: 65733,
  //   seasonNumber: 1,
  // );

  // log(episodes.toString());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeState = ref.watch(themeStateControllerProvider);
    final isDarkMode = themeState.themeMode == ThemeMode.dark;
    final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
    return MaterialApp(
      theme: theme,
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,
      // home: MediaGridViewScreen.standalone(
      //     type: AllMediaType.movies,
      //     appbarTitle: 'Latest Top Rated Action Movies',
      //     filters: MediaDiscoveryFilterModel(
      //         ratings: (min: 8.0, max: 10.0),
      //         releaseYearRange: (from: 2023, to: 2025)))
      // home: MediaGalleryScreen.availableData(
      //   categorizedMediaImages:
      //       CategorizedMediaImageModel.fromMap(categorizedImages),
      //   mediaVideos: videos,
      // ),
      // home: MediaGalleryScreen.loadData(
      // home: DetailedMediaScreen(
      //     mediaType: GalleryMediaType.movie, mediaId: 1397832),
      // home: MediaLibraryScreen(libraryType: MediaLibraryType.favorites),
      // home: KeywordSearchScreen(),
      // home: GenreScreen(),
      home: HomeScreen(),
      // home: PersonProfileScreen(personId: 287),
      // home: DiscoverScreen(),
      // home: SimpleScreen(),
    );
  }
}
