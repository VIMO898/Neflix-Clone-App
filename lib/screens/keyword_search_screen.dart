import 'dart:async';
import 'dart:developer';

import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/general/keyword_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/widgets/general/centered_message.dart';
import 'package:app/widgets/search/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/search_utils.dart';
import '../widgets/keyword_search/selected_keyword_dialog.dart';

class KeywordSearchScreen extends ConsumerStatefulWidget {
  const KeywordSearchScreen({super.key});

  @override
  ConsumerState<KeywordSearchScreen> createState() =>
      _KeywordSearchScreenState();
}

class _KeywordSearchScreenState extends ConsumerState<KeywordSearchScreen> {
  late ScrollController _scrollController;
  String _query = '';
  Timer? _debounce;
  TmdbResult<KeywordModel>? _searchedKeywords;
  final List<KeywordModel> _selectedKeywords = [];
  int _currPage = 1;
  TmdbException? _tmdbException;
  bool _hasError = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String? newQuery, [bool merge = false]) async {
    if (newQuery == null || newQuery.isEmpty) return;
    final repo = ref.read(tmdbRepoProvider);

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        // before loading data
        _tmdbException = null;
        _hasError = false;
        if (_query != newQuery) {
          _query = newQuery;
          _currPage = 1;
        }
        merge ? _isLoadingMore = true : _isLoading = true;
        setState(() {});
        // sending request
        final newResults = await repo.searchMediaKeywords(newQuery, _currPage);
        _searchedKeywords = merge && _searchedKeywords != null
            ? mergeTmdbResults<KeywordModel>(_searchedKeywords!, newResults)
            : newResults;
        // after data being loaded
        merge ? _isLoadingMore = false : _isLoading = false;
        setState(() {});
      } on TmdbException catch (e) {
        log(e.toString());
        _isLoading = false;
        _isLoadingMore = false;
        _tmdbException = e;
        _hasError = true;
        setState(() {});
      } catch (e) {
        log(e.toString());
        _isLoading = false;
        _isLoadingMore = false;
        _tmdbException = null;
        _hasError = true;
        setState(() {});
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50 &&
        !_isLoadingMore &&
        _searchedKeywords != null &&
        _currPage < _searchedKeywords!.totalPages) {
      _handleLoadPage();
    }
  }

  void _handleLoadPage() {
    if (_searchedKeywords != null ||
        _currPage + 1 > _searchedKeywords!.totalPages) {
      return;
    }
    _currPage++;
    _handleSearch(_query, true);
  }

  void _handleToggleKeywordSelect(KeywordModel keyword) {
    if (_selectedKeywords.contains(keyword)) {
      _selectedKeywords.remove(keyword);
    } else {
      _selectedKeywords.add(keyword);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    log((_searchedKeywords?.results ?? 'null').toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Search & Select Keywords'),
        actions: [_buildKeywordCart(textTheme, theme)],
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: theme.scaffoldBackgroundColor,
            width: double.infinity,
            height: 75,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: SearchField(
              hintText: 'Search Keywords...',
              onChanged: (query) => _handleSearch(query),
            ),
          ),
          _isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(child: CircularProgressIndicator()),
                )
              : _tmdbException != null || _hasError
              ? _buildErrorMessage()
              : (_searchedKeywords?.results.isEmpty ?? true)
              ? _buildEmptyListMessage()
              : Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        _searchedKeywords!.results.length +
                        (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _searchedKeywords!.results.length &&
                          _isLoadingMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final keyword = _searchedKeywords!.results[index];
                      return ListTile(
                        onTap: () => _handleToggleKeywordSelect(keyword),
                        shape: Border(
                          bottom: BorderSide(
                            color: colorScheme.secondary,
                            width: 0.2,
                          ),
                        ),
                        title: Text(keyword.name, style: textTheme.titleLarge),
                        trailing: _selectedKeywords.contains(keyword)
                            ? Icon(Icons.done)
                            : null,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  IconButton _buildKeywordCart(TextTheme textTheme, ThemeData theme) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SelectedKeywordDialog(
            selectedKeywords: _selectedKeywords,
            onRemoveSelectedKeyword: _handleToggleKeywordSelect,
          ),
        );
      },
      icon: Badge(
        label: Text(_selectedKeywords.length.toString()),
        textStyle: textTheme.bodyMedium,
        padding: const EdgeInsets.all(0.85),
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.keyboard_outlined, size: 32),
      ),
    );
  }

  CenteredMessage _buildEmptyListMessage() => CenteredMessage(
    padding: const EdgeInsets.fromLTRB(12, 150, 12, 0),
    icon: Icons.rocket_outlined,
    title: 'Start Searching Keywords',
    subtitle: 'In order to see suggestions right here.',
  );

  CenteredMessage _buildErrorMessage() {
    return CenteredMessage(
      padding: const EdgeInsets.fromLTRB(12, 150, 12, 0),
      title: _tmdbException?.statusCode?.toString() ?? '404',
      subtitle:
          _tmdbException?.statusMessage ??
          'Something went wrong, please check your internet connection status',
    );
  }
}
