import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/people/person_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/providers/controllers/app_setting_controller_provider.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/utils/all_media_type_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/search_utils.dart';
import '../widgets/general/centered_message.dart';
import '../widgets/media_grid_view/media_category_list_view.dart';

class MediaGridViewScreen extends ConsumerStatefulWidget {
  final String appbarTitle;
  final AllMediaType type;
  final MediaDiscoveryFilterModel? filters;
  final Enum? mediaCategory;
  final MediaGridViewScreenType screenType;

  const MediaGridViewScreen({
    super.key,
    required this.appbarTitle,
    required this.type,
    this.mediaCategory,
  }) : screenType = MediaGridViewScreenType.withoutScaffold,
       filters = null;

  const MediaGridViewScreen.withScaffold({
    super.key,
    required this.appbarTitle,
    required this.type,
    this.filters,
    this.mediaCategory,
  }) : screenType = MediaGridViewScreenType.withScaffold;

  @override
  ConsumerState<MediaGridViewScreen> createState() =>
      _CategorizedMovieListScreenState();
}

class _CategorizedMovieListScreenState
    extends ConsumerState<MediaGridViewScreen> {
  late ScrollController _scrollController;
  int _currPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  TmdbException? _tmdbException;
  bool _hasError = false;
  TmdbResult? _tmdbData;
  late Enum _selectedMediaCategory;
  // late MediaPosterSize _mediaPosterSize;

  @override
  void initState() {
    super.initState();
    // final appSettings = ref.read(appSettingControllerProvider);
    // _mediaPosterSize = appSettings.mediaPosterSize;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _selectedMediaCategory =
        widget.mediaCategory ??
        switch (widget.type) {
          AllMediaType.movies => MovieCategory.popular,
          AllMediaType.tvShows => TvShowCategory.popular,
          AllMediaType.people => PersonCategory.popular,
        };
    _handleLoadMedia();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _tmdbData != null &&
        _currPage < _tmdbData!.totalPages) {
      _handleLoadPage();
    }
  }

  Future<void> _handleLoadMedia([bool isCategoryChanged = false]) async {
    final tmdbRepo = ref.read(tmdbRepoProvider);
    try {
      final merge = _tmdbData != null;
      if (merge && !isCategoryChanged) {
        _isLoadingMore = true;
        _isLoading = false;
      } else {
        _isLoading = true;
        _isLoadingMore = false;
      }
      _hasError = false;
      _tmdbException = null;
      setState(() {});
      switch (widget.type) {
        case AllMediaType.movies:
          late TmdbResult<MovieOverviewModel> newResults;
          if (widget.screenType == MediaGridViewScreenType.withoutScaffold ||
              widget.mediaCategory != null) {
            switch (_selectedMediaCategory) {
              case MovieCategory.popular:
                newResults = await tmdbRepo.getPopularMovies(_currPage);
              case MovieCategory.trending:
                newResults = await tmdbRepo.getTrendingMovies(_currPage);
              case MovieCategory.topRated:
                newResults = await tmdbRepo.getTopRatedMovies(_currPage);
              case MovieCategory.nowPlaying:
                newResults = await tmdbRepo.getNowPlayingMovies(_currPage);
              case MovieCategory.upcoming:
                newResults = await tmdbRepo.getUpcomingMovies(_currPage);
            }
          } else {
            newResults = await tmdbRepo.discoverMovies(
              filters: widget.filters!,
              page: _currPage,
            );
          }
          _tmdbData = merge && !isCategoryChanged
              ? mergeTmdbResults<MovieOverviewModel>(
                  _tmdbData! as TmdbResult<MovieOverviewModel>,
                  newResults,
                )
              : _tmdbData = newResults;
        case AllMediaType.tvShows:
          late TmdbResult<TvShowOverviewModel> newResults;
          if (widget.screenType == MediaGridViewScreenType.withoutScaffold ||
              widget.mediaCategory != null) {
            switch (_selectedMediaCategory) {
              case TvShowCategory.popular:
                newResults = await tmdbRepo.getPopularTvShows(_currPage);
              case TvShowCategory.trending:
                newResults = await tmdbRepo.getTrendingTvShows(_currPage);
              case TvShowCategory.topRated:
                newResults = await tmdbRepo.getTopRatedTvShows(_currPage);
              case TvShowCategory.onTheAir:
                newResults = await tmdbRepo.getOnTheAirTvShows(_currPage);
              case TvShowCategory.airingToday:
                newResults = await tmdbRepo.getAiringTodayTvShows(_currPage);
            }
          } else {
            newResults = await tmdbRepo.discoverTvShows(
              filters: widget.filters!,
              page: _currPage,
            );
          }
          _tmdbData = merge && !isCategoryChanged
              ? mergeTmdbResults<TvShowOverviewModel>(
                  _tmdbData! as TmdbResult<TvShowOverviewModel>,
                  newResults,
                )
              : _tmdbData = newResults;

        case AllMediaType.people:
          late TmdbResult<PersonModel> newResults;
          switch (_selectedMediaCategory) {
            case PersonCategory.popular:
              newResults = await tmdbRepo.getPopularPeople(_currPage);
            case PersonCategory.trending:
              newResults = await tmdbRepo.getTrendingPeople(
                trendingTimeWindowint: PeopleTrendingTimeWindow.week,
                page: _currPage,
              );
          }
          _tmdbData = merge && !isCategoryChanged
              ? mergeTmdbResults<PersonModel>(
                  _tmdbData! as TmdbResult<PersonModel>,
                  newResults,
                )
              : _tmdbData = newResults;
      }
      _isLoading = false;
      _isLoadingMore = false;
      setState(() {});
    } on TmdbException catch (e) {
      log(e.toString());
      _isLoading = false;
      _isLoadingMore = false;
      _hasError = true;
      _tmdbData = null;
      _tmdbException = e;
      setState(() {});
    } catch (e) {
      log(e.toString());
      _isLoading = false;
      _isLoadingMore = false;
      _tmdbException = null;
      _tmdbData = null;
      _hasError = true;
      setState(() {});
    }
  }

  void _handleLoadPage() {
    if (_tmdbData == null || _currPage + 1 > _tmdbData!.totalPages) return;
    _currPage++;
    _handleLoadMedia();
  }

  void _handleChangeMediaCategory(Enum updatedCategory) {
    _selectedMediaCategory = updatedCategory;
    _handleLoadMedia(true);
  }

  Future<void> _handleRefreshState() async {
    if (_isLoading) return;
    _currPage = 1;
    _tmdbException = null;
    _hasError = false;
    _tmdbData = null;
    return _handleLoadMedia();
  }

  @override
  Widget build(BuildContext context) {
    return widget.screenType == MediaGridViewScreenType.withoutScaffold
        ? _buildScaffoldBody()
        : Scaffold(
            appBar: AppBar(title: Text(widget.appbarTitle)),
            body: _buildScaffoldBody(),
          );
  }

  Widget _buildScaffoldBody() {
    return RefreshIndicator(
      displacement: 10.0, // vertical position (default is 40)
      onRefresh: _handleRefreshState,
      child: _tmdbException != null || _hasError
          ? CenteredMessage(
              iconColor: Colors.redAccent,
              title: _tmdbException?.statusCode?.toString() ?? '404',
              subtitle:
                  _tmdbException?.statusMessage ??
                  'Something went wrong, please check your internet connection status',
              onRefresh: _handleLoadMedia,
            )
          : _buildMediaGridView(),
    );
  }

  Widget _buildMediaGridView() {
    // final results = _tmdbData?.results;
    final cards = allMediaTypeCardList(
      context,
      isLoading: _isLoading,
      type: widget.type,
      mediaList: !_isLoading ? _tmdbData!.results as List<Object> : null,
    );
    final appSettings = ref.watch(appSettingControllerProvider);
    final mediaPosterSize = appSettings.mediaPosterSize;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (widget.screenType == MediaGridViewScreenType.withoutScaffold)
            SliverToBoxAdapter(
              child: MediaCategoryListView(
                type: widget.type,
                selectedCategory: _selectedMediaCategory,
                onUpdateCategory: _handleChangeMediaCategory,
              ),
            ),
          SliverGrid.builder(
            itemCount: cards.length,
            gridDelegate: _buildGridDelegateForPosterSize(mediaPosterSize),
            itemBuilder: (context, index) {
              return cards[index];
            },
          ),
          if (_isLoadingMore)
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              sliver: SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  SliverGridDelegate _buildGridDelegateForPosterSize(MediaPosterSize size) {
    switch (size) {
      case MediaPosterSize.small:
        return const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 6,
          mainAxisExtent: 190,
        );
      case MediaPosterSize.medium:
        return const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 12,
          mainAxisExtent: 250,
        );
      case MediaPosterSize.large:
        return const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 26,
          crossAxisSpacing: 18,
          mainAxisExtent: 320,
        );
    }
  }
}
