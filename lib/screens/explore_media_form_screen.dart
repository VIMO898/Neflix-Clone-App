import 'dart:developer';

import 'package:app/models/general/media_discovery_filter_model.dart';
import 'package:app/screens/explore_media_list_view_screen.dart';
import 'package:app/widgets/exlore_media_form/genre_dropdown.dart';
import 'package:app/widgets/exlore_media_form/rating_dropdown.dart';
import 'package:app/widgets/exlore_media_form/sort_by_dropdown.dart';
import 'package:app/widgets/exlore_media_form/year_dropdown.dart';
import 'package:app/widgets/general/full_width_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/enums.dart';
import '../models/general/genre_model.dart';
import '../utils/navigator_shortcuts.dart';
import '../widgets/exlore_media_form/explore_media_types.dart';
import '../widgets/exlore_media_form/runtime_dropdown.dart';

class ExploreMediaFormScreen extends ConsumerStatefulWidget {
  const ExploreMediaFormScreen({super.key});

  @override
  ConsumerState<ExploreMediaFormScreen> createState() =>
      _ExploreMediaFormScreenState();
}

class _ExploreMediaFormScreenState
    extends ConsumerState<ExploreMediaFormScreen> {
  ExploreMediaType _mediaType = ExploreMediaType.tvShows;
  GenreModel? _selectedGenre;
  double _minRatings = 0.0;
  double _maxRatings = 10.0;
  int _fromYear = 1975;
  int _toYear = DateTime.now().year;
  SortOrder _sortOrder = SortOrder.ascending;
  SortBy _sortBy = SortBy.rating;
  late int _minRuntime;
  late int _maxRuntime;

  @override
  void initState() {
    super.initState();
    final runtimeRange = getRuntimeRange(_mediaType);
    _minRuntime = runtimeRange.min.first;
    _maxRuntime = runtimeRange.max.first;
  }

  void _handleMediaTypeChange(ExploreMediaType updatedMediaType) {
    _mediaType = updatedMediaType;
    // set genre to null
    _selectedGenre = null;
    // update runtime
    final updatedRuntime = getRuntimeRange(_mediaType);
    _handleRuntimeRangeChange(
      updatedRuntime.min.first,
      updatedRuntime.max.first,
    );
    setState(() {});
  }

  void _handleGenreChange({
    GenreModel? selectedMovieGenre,
    GenreModel? selectedTvShowGenre,
  }) {
    if (selectedMovieGenre != null) _selectedGenre = selectedMovieGenre;
    if (selectedTvShowGenre != null) _selectedGenre = selectedTvShowGenre;
    setState(() {});
  }

  void _handleRuntimeRangeChange(int min, int max) {
    _minRuntime = min;
    _maxRuntime = max;
  }

  void _handleSortChange(SortBy sortBy, SortOrder sortOrder) {
    _sortBy = sortBy;
    _sortOrder = sortOrder;
  }

  void _handleRatingChange(double minRatings, double maxRatings) {
    _minRatings = minRatings;
    _maxRatings = maxRatings;
  }

  void _handleYearChange(int from, int to) {
    log({'from': from}.toString());
    log({'to': to}.toString());
    _fromYear = from;
    _toYear = to;
    setState(() {});
  }

  void _handleFormSubmission() {
    final filters = MediaDiscoveryFilterModel(
      genres: [if (_selectedGenre != null) _selectedGenre!],
      ratings: (min: _minRatings, max: _maxRatings),
      releaseYearRange: (from: _fromYear, to: _toYear),
      runtimeRange: (min: _minRuntime, max: _maxRuntime),
      sortBy: _sortBy,
      sortOrder: _sortOrder,
    );
    NavHelper.push(
      context,
      ExploreMediaListViewScreen(mediaType: _mediaType, filters: filters),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final textTheme = theme.textTheme;
    // final currYear = DateTime.now().year;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExploreMediaTypes(
            mediaType: _mediaType,
            onSelect: _handleMediaTypeChange,
          ),
          GenreDropdown(
            mediaType: _mediaType,
            selectedGenreName: _selectedGenre?.name ?? 'All Genres',
            onChange: _handleGenreChange,
          ),
          RatingDropdown(
            min: _minRatings,
            max: _maxRatings,
            onChange: _handleRatingChange,
          ),
          YearDropdown(
            from: _fromYear,
            to: _toYear,
            onChange: _handleYearChange,
          ),
          SortDropdown(
            sortBy: SortBy.popularity,
            sortOrder: SortOrder.ascending,
            onChange: _handleSortChange,
          ),
          RuntimeDropdown(
            runtimeRange: getRuntimeRange(_mediaType),
            min: _minRuntime,
            max: _maxRuntime,
            onChange: _handleRuntimeRangeChange,
          ),
          FullWidthElevatedButton(
            padding: const EdgeInsets.symmetric(vertical: 16),
            text: 'Explore Now',
            icon: Icons.search,
            onTap: _handleFormSubmission,
          ),
        ],
      ),
    );
  }
}

({List<int> min, List<int> max}) getRuntimeRange(ExploreMediaType mediaType) {
  final minMovieRuntime = [30, 60, 90, 120];
  final maxMovieRuntime = [150, 180, 210, 240];
  final minTvShowRuntime = [10, 20, 30];
  final maxTvShowRuntime = [45, 60, 75, 90];
  // final minAllRuntime = [10, 20, 30, 60, 90, 120];
  // final maxAllRuntime = [45, 60, 75, 90, 150, 180, 210, 240];

  switch (mediaType) {
    // case ExploreMediaType.all:
    //   return (min: minAllRuntime, max: maxAllRuntime);
    case ExploreMediaType.movies:
      return (min: minMovieRuntime, max: maxMovieRuntime);
    case ExploreMediaType.tvShows:
      return (min: minTvShowRuntime, max: maxTvShowRuntime);
  }
}
