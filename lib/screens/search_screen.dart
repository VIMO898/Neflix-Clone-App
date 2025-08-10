import 'dart:async';
import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/people/person_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/providers/general/movie_genres_provider.dart';
import 'package:app/providers/general/tv_show_genres_provider.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/utils/all_media_type_tile_list.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/general/centered_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/tmdb_exception.dart';
import '../models/general/genre_model.dart';
import '../utils/search_utils.dart';
import '../widgets/search/search_field.dart';
import '../widgets/search/search_type_dialog.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late ScrollController _scrollController;
  Timer? _debounce;
  AllMediaType _searchType = AllMediaType.movies;
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  String _query = '';
  int _currPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  TmdbException? _exception;
  bool _hasError = false;
  TmdbResult? _searchedResults;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchTextEditingController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _searchedResults != null &&
        _currPage < _searchedResults!.totalPages) {
      _handleLoadPage();
    }
  }

  void _handleSearch(String? newQuery, [bool merge = false]) {
    if (newQuery == null || newQuery.isEmpty) return;
    final repo = ref.read(tmdbRepoProvider);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      try {
        _exception = null;
        if (_query != newQuery) {
          _query = newQuery;
          _currPage = 1;
        }
        merge ? _isLoadingMore = true : _isLoading = true;
        setState(() {});
        switch (_searchType) {
          case AllMediaType.movies:
            final newResults = await repo.searchMovies(newQuery, _currPage);
            _searchedResults = merge && _searchedResults != null
                ? mergeTmdbResults<MovieOverviewModel>(
                    _searchedResults! as TmdbResult<MovieOverviewModel>,
                    newResults,
                  )
                : newResults;
          case AllMediaType.tvShows:
            final newResults = await repo.searchTvShows(newQuery, _currPage);
            _searchedResults = merge && _searchedResults != null
                ? mergeTmdbResults<TvShowOverviewModel>(
                    _searchedResults! as TmdbResult<TvShowOverviewModel>,
                    newResults,
                  )
                : newResults;
          case AllMediaType.people:
            final newResults = await repo.searchPeople(newQuery, _currPage);
            _searchedResults = merge && _searchedResults != null
                ? mergeTmdbResults<PersonModel>(
                    _searchedResults! as TmdbResult<PersonModel>,
                    newResults,
                  )
                : newResults;
        }
        setState(() {
          _isLoading = false;
          _isLoadingMore = false;
        });
      } on TmdbException catch (e) {
        log(e.toString());
        _isLoading = false;
        _isLoadingMore = false;
        _exception = e;
        _hasError = true;
        setState(() {});
      } catch (e) {
        log(e.toString());
        _isLoading = false;
        _isLoadingMore = false;
        _exception = null;
        _hasError = true;
        setState(() {});
      }
    });
  }

  void _handleLoadPage() {
    if (_searchedResults == null ||
        _currPage + 1 > _searchedResults!.totalPages) {
      return;
    }
    _currPage++;
    _handleSearch(_query, true);
  }

  void _handleChangeSearchType(String? val) {
    final searchTypes = AllMediaType.values;
    final selectedType = searchTypes.firstWhere(
      (t) => t.name.readable() == val,
    );
    setState(() {
      _query = '';
      _searchTextEditingController.clear();
      _searchType = selectedType;
      _searchedResults = null;
      _exception = null;
      _isLoading = false;
      _isLoadingMore = false;
      _currPage = 1;
      _debounce = null;
      _hasError = false;
    });
    NavHelper.pop(context);
  }

  void _handleOpenSearchTypeChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => SearchTypeDialog(
        currSearchType: _searchType,
        onChanged: _handleChangeSearchType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieGenres = ref.watch(movieGenresProvider);
    final tvShowGenres = ref.watch(tvShowGenresProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(switch (_searchType) {
          AllMediaType.movies => 'Search Movies',
          AllMediaType.tvShows => 'Search TV Shows',
          AllMediaType.people => 'Search Celebs',
        }),
        actions: [
          IconButton(
            onPressed: _handleOpenSearchTypeChangeDialog,
            icon: Icon(searchTypeIcons[_searchType]),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              controller: _searchTextEditingController,
              hintText: 'Search here...',
              onChanged: _handleSearch,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: _query.isEmpty
                  ? emptyQueryContent[_searchType]!
                  : _exception != null || _hasError
                  ? _buildErrorMessage()
                  : _buildResultList(movieGenres, tvShowGenres),
            ),
          ],
        ),
      ),
    );
  }

  CenteredMessage _buildErrorMessage() {
    return CenteredMessage(
      iconColor: Colors.redAccent,
      title: _exception?.statusCode?.toString() ?? '404',
      subtitle:
          _exception?.statusMessage ??
          'Something went wrong, please check your internet connection status',
    );
  }

  Widget _buildResultList(
    List<GenreModel> movieGenres,
    List<GenreModel> tvGenres,
  ) {
    final data = _searchedResults;

    final tiles = allMediaTypeTileList(
      context,
      type: _searchType,
      isLoading: _isLoading,
      mediaList: !_isLoading ? data!.results as List<Object> : null,
      movieGenres: movieGenres,
      tvShowGenres: tvGenres,
    );

    return ListView.builder(
      controller: _scrollController,
      itemCount: tiles.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == tiles.length && _isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return tiles[index];
      },
    );
  }
}
