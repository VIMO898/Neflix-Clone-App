import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/providers/general/movie_genres_provider.dart';
import 'package:app/providers/general/tv_show_genres_provider.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/utils/all_media_type_tile_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movies/movie_overview_model.dart';
import '../models/shows/tv_show_overview_model.dart';
import '../utils/search_utils.dart';
import '../widgets/general/centered_message.dart';

class ExploreMediaListViewScreen extends ConsumerStatefulWidget {
  final ExploreMediaType mediaType;
  final MediaDiscoveryFilterModel filters;
  const ExploreMediaListViewScreen({
    super.key,
    required this.mediaType,
    required this.filters,
  });

  @override
  ConsumerState<ExploreMediaListViewScreen> createState() =>
      _ExploreMediaListViewScreenState();
}

class _ExploreMediaListViewScreenState
    extends ConsumerState<ExploreMediaListViewScreen> {
  late ScrollController _scrollController;
  int _currPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  TmdbException? _exception;
  bool _hasError = false;
  TmdbResult? _tmdbResults;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _discoverMediaViaFilters();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _tmdbResults != null &&
        _currPage < _tmdbResults!.totalPages) {
      _handleLoadPage();
    }
  }

  void _discoverMediaViaFilters() async {
    final merge = _tmdbResults != null;
    if (!merge) _isLoading = true;
    if (merge) _isLoadingMore = true;
    _hasError = false;
    _exception = null;
    setState(() {});
    try {
      final repo = ref.read(tmdbRepoProvider);
      switch (widget.mediaType) {
        case ExploreMediaType.movies:
          final newResults = await repo.discoverMovies(
            filters: widget.filters,
            page: _currPage,
          );
          _tmdbResults = merge
              ? mergeTmdbResults<MovieOverviewModel>(
                  _tmdbResults! as TmdbResult<MovieOverviewModel>,
                  newResults,
                )
              : newResults;
        case ExploreMediaType.tvShows:
          final newResults = await repo.discoverTvShows(
            filters: widget.filters,
            page: _currPage,
          );
          _tmdbResults = merge
              ? mergeTmdbResults<TvShowOverviewModel>(
                  _tmdbResults! as TmdbResult<TvShowOverviewModel>,
                  newResults,
                )
              : newResults;
      }

      _isLoading = false;
      _isLoadingMore = false;
      setState(() {});
    } on TmdbException catch (e) {
      _isLoading = false;
      _isLoadingMore = false;
      _hasError = true;
      _exception = e;
      setState(() {});
    } catch (e) {
      _isLoading = false;
      _isLoadingMore = false;
      _exception = null;
      _hasError = true;
      setState(() {});
    }
  }

  void _handleLoadPage() {
    if (_tmdbResults == null) return;
    if (_currPage + 1 > _tmdbResults!.totalPages) return;
    _currPage++;
    _discoverMediaViaFilters();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefreshState() async {
    if (_isLoading) return;
    _currPage = 1;
    _exception = null;
    _hasError = false;
    _tmdbResults = null;
    return _discoverMediaViaFilters();
  }

  @override
  Widget build(BuildContext context) {
    log(_currPage.toString());
    return Scaffold(
      appBar: AppBar(title: Text('Explore'), centerTitle: true),
      body: RefreshIndicator(
        displacement: 10.0, // vertical position (default is 40)
        onRefresh: _handleRefreshState,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: _exception != null || _hasError
              ? CenteredMessage(
                  iconColor: Colors.redAccent,
                  title: _exception?.statusCode?.toString() ?? '404',
                  subtitle:
                      _exception?.statusMessage ??
                      'Something went wrong, please check your internet connection status',
                  onRefresh: _handleRefreshState,
                )
              : _buildResultList(),
        ),
      ),
    );
  }

  Widget _buildResultList() {
    final movieGenres = ref.read(movieGenresProvider);
    final tvShowGenres = ref.read(tvShowGenresProvider);
    final mediaType = widget.mediaType == ExploreMediaType.movies
        ? AllMediaType.movies
        : AllMediaType.tvShows;
    final tiles = allMediaTypeTileList(
      context,
      isLoading: _isLoading,
      type: mediaType,
      mediaList: !_isLoading ? _tmdbResults!.results as List<Object>? : null,
      movieGenres: movieGenres,
      tvShowGenres: tvShowGenres,
    );

    return ListView.builder(
      controller: _scrollController,
      itemCount: tiles.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == tiles.length && _isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return tiles[index];
      },
    );
  }
}
