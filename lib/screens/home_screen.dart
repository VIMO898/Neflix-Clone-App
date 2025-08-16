import 'package:app/constants/enums.dart';
import 'package:app/screens/setting_screen.dart' show SettingScreen;
import 'package:app/widgets/general/home_drawer_screen_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/controllers/app_setting_controller_provider.dart';
import '../utils/navigator_shortcuts.dart';
import '../widgets/home/home_drawer_tile.dart';
import 'discover_screen.dart';
import 'explore_media_form_screen.dart';
import 'genre_screen.dart';
import 'media_grid_view_screen.dart';
import 'media_library_screen.dart';
import 'search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late MovieCategory _defaultMovieTab;
  late TvShowCategory _defaultTvShowTab;
  late HomeDrawerScreenInfoModel _selectedScreenInfo;
  @override
  void initState() {
    super.initState();
    final appSettings = ref.read(appSettingControllerProvider);
    _defaultMovieTab = appSettings.defaultMovieTab;
    _defaultTvShowTab = appSettings.defaultTvShowTab;
    final defaultScreen = switch (appSettings.defaultHomeScreen) {
      DefaultHomeScreen.discover => HomeDrawerScreenInfoModel(
        title: 'Discover',
        icon: Icons.rocket_outlined,
        screen: DiscoverScreen(),
      ),
      DefaultHomeScreen.movies => HomeDrawerScreenInfoModel(
        title: 'Movies',
        icon: Icons.movie_outlined,
        screen: MediaGridViewScreen(
          type: AllMediaType.movies,
          mediaCategory: _defaultMovieTab,
          appbarTitle: 'Movies',
        ),
      ),
      DefaultHomeScreen.tvShows => HomeDrawerScreenInfoModel(
        title: 'TV Shows',
        icon: Icons.tv_outlined,
        screen: MediaGridViewScreen(
          type: AllMediaType.tvShows,
          mediaCategory: _defaultTvShowTab,
          appbarTitle: 'TV Shows',
        ),
      ),
    };
    _selectedScreenInfo = defaultScreen;
  }

  void _handleUpdateScreen(HomeDrawerScreenInfoModel screenInfo) {
    _scaffoldKey.currentState?.closeDrawer();
    if (screenInfo.isDedicatedScreen) {
      NavHelper.push(context, screenInfo.screen);
      return;
    }
    _selectedScreenInfo = screenInfo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final generalScreens = [
      HomeDrawerScreenInfoModel(
        title: 'Discover',
        icon: Icons.rocket_outlined,
        screen: DiscoverScreen(),
      ),
      HomeDrawerScreenInfoModel(
        title: 'Movies',
        icon: Icons.movie_outlined,
        screen: MediaGridViewScreen(
          key: Key('Movies'),
          type: AllMediaType.movies,
          mediaCategory: _defaultMovieTab,
          appbarTitle: 'Movies',
        ),
      ),
      HomeDrawerScreenInfoModel(
        title: 'TV Shows',
        icon: Icons.tv_outlined,
        screen: MediaGridViewScreen(
          key: Key('TV Shows'),
          type: AllMediaType.tvShows,
          mediaCategory: _defaultTvShowTab,
          appbarTitle: 'TV Shows',
        ),
      ),

      HomeDrawerScreenInfoModel(
        title: 'People',
        icon: Icons.account_box_outlined,
        screen: MediaGridViewScreen(
          key: Key('People'),
          type: AllMediaType.people,
          appbarTitle: 'People',
        ),
      ),

      HomeDrawerScreenInfoModel(
        title: 'Explore',
        icon: Icons.manage_search_outlined,
        screen: ExploreMediaFormScreen(),
      ),
      HomeDrawerScreenInfoModel(
        title: 'Genres',
        icon: Icons.category_outlined,
        screen: GenreScreen(),
        isDedicatedScreen: true,
      ),
    ];
    final userScreens = [
      HomeDrawerScreenInfoModel(
        title: 'Favourites',
        icon: Icons.favorite_outline,
        screen: MediaLibraryScreen(libraryType: MediaLibraryType.favorites),
      ),
      HomeDrawerScreenInfoModel(
        title: 'WatchList',
        icon: Icons.watch_later_outlined,
        screen: MediaLibraryScreen(libraryType: MediaLibraryType.watchlist),
      ),
      HomeDrawerScreenInfoModel(
        title: 'Already Watched',
        icon: Icons.visibility_outlined,
        screen: MediaLibraryScreen(
          libraryType: MediaLibraryType.alreadyWatchedlist,
        ),
      ),
    ];
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.8;
    final logoWidth = drawerWidth * 0.8;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_selectedScreenInfo.title),
        actions: [
          IconButton(onPressed: null, icon: const Icon(Icons.cast)),
          IconButton(
            onPressed: () => NavHelper.push(context, SearchScreen()),
            icon: const Icon(Icons.search),
          ),
        ],
        // bottom: appBarBottom,
      ),
      body: _selectedScreenInfo.screen,
      // body: IndexedStack,
      drawer: Drawer(
        width: drawerWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDrawerLogo(theme, logoWidth),
              // ========
              //   General
              // ========
              ...List.generate(generalScreens.length, (index) {
                final screenInfo = generalScreens[index];
                return HomeDrawerTile(
                  title: screenInfo.title,
                  icon: screenInfo.icon,
                  isSelected: _selectedScreenInfo.title == screenInfo.title,
                  onTap: () => _handleUpdateScreen(screenInfo),
                );
              }),
              // ========
              //   User
              // ========
              _buildTilesCategoryTitle('User', theme),
              ...List.generate(userScreens.length, (index) {
                final screenInfo = userScreens[index];
                return HomeDrawerTile(
                  title: screenInfo.title,
                  icon: screenInfo.icon,
                  isSelected: _selectedScreenInfo.title == screenInfo.title,
                  onTap: () => _handleUpdateScreen(screenInfo),
                );
              }),
              // ========
              //   Other
              // ========
              _buildTilesCategoryTitle('Other', theme),
              HomeDrawerTile(
                title: 'Settings',
                icon: Icons.settings_outlined,
                isSelected: false,
                onTap: () {
                  _scaffoldKey.currentState?.closeDrawer();
                  NavHelper.push(context, SettingScreen());
                },
              ),
              HomeDrawerTile(
                title: 'Check Update',
                isSelected: false,
                icon: Icons.download_outlined,
                onTap: () {},
              ),
              _buildAppVersionText(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDrawerLogo(ThemeData theme, double logoWidth) {
    return Container(
      height: 220,
      width: double.infinity,
      color: theme.cardColor,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      margin: const EdgeInsets.only(bottom: 16),
      child: Image.asset(
        'assets/images/netflix_logo.png',
        width: logoWidth,
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
      ),
    );
  }

  Padding _buildAppVersionText(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Text(
        'Version: 1.0.0',
        textAlign: TextAlign.center,
        style: textTheme.bodyLarge,
      ),
    );
  }

  Container _buildTilesCategoryTitle(String title, ThemeData theme) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(12, 4, 0, 10),
      child: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontSize: 19),
      ),
    );
  }
}
