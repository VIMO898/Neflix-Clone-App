import 'package:app/constants/enums.dart';
import 'package:app/models/general/genre_model.dart';
import 'package:app/widgets/general/padded_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/general/movie_genres_provider.dart';
import '../../providers/general/tv_show_genres_provider.dart';
import '../general/primary_drop_down_button.dart';

class GenreDropdown extends ConsumerStatefulWidget {
  final ExploreMediaType mediaType;
  final String selectedGenreName;
  final void Function({
    GenreModel? selectedMovieGenre,
    GenreModel? selectedTvShowGenre,
  })
  onChange;

  const GenreDropdown({
    super.key,
    required this.mediaType,
    required this.selectedGenreName,
    required this.onChange,
  });

  @override
  ConsumerState<GenreDropdown> createState() => _GenreDropdownState();
}

class _GenreDropdownState extends ConsumerState<GenreDropdown> {
  late final List<GenreModel> _movieGenres;
  late final List<GenreModel> _tvShowGenres;
  late final List<String> _movieGenreNames;
  late final List<String> _tvShowGenreNames;

  @override
  void initState() {
    super.initState();
    _initializeGenres();
  }

  void _initializeGenres() {
    final movieGenres = List<GenreModel>.from(ref.read(movieGenresProvider));
    final tvShowGenres = List<GenreModel>.from(ref.read(tvShowGenresProvider));

    const allGenre = GenreModel(id: 0, name: 'All Genres');
    if (!movieGenres.any((g) => g.name == allGenre.name)) {
      movieGenres.add(allGenre);
    }
    if (!tvShowGenres.any((g) => g.name == allGenre.name)) {
      tvShowGenres.add(allGenre);
    }

    _movieGenres = movieGenres;
    _tvShowGenres = tvShowGenres;

    _movieGenreNames = _movieGenres.map((g) => g.name).toList();
    _tvShowGenreNames = _tvShowGenres.map((g) => g.name).toList();
  }

  List<String> _getGenresToDisplay() {
    switch (widget.mediaType) {
      case ExploreMediaType.movies:
        return _movieGenreNames;
      case ExploreMediaType.tvShows:
        return _tvShowGenreNames;
      // case ExploreMediaType.all:
      //   return _movieGenreNames.toSet().intersection(_tvShowGenreNames.toSet()).toList();
    }
  }

  GenreModel? _findGenre(String name, List<GenreModel> genres) {
    return genres.firstWhere(
      (g) => g.name == name,
      orElse: () => GenreModel(id: 0, name: name),
    );
  }

  void _handleGenreChange(String? genreName) {
    if (genreName == null) return;

    final selectedMovieGenre = widget.mediaType != ExploreMediaType.tvShows
        ? _findGenre(genreName, _movieGenres)
        : null;
    final selectedTvShowGenre = widget.mediaType != ExploreMediaType.movies
        ? _findGenre(genreName, _tvShowGenres)
        : null;

    widget.onChange(
      selectedMovieGenre: selectedMovieGenre,
      selectedTvShowGenre: selectedTvShowGenre,
    );
  }

  @override
  Widget build(BuildContext context) {
    final genresToDisplay = _getGenresToDisplay();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PaddedText('Genre'),
        OutlinedDropdownButton(
          items: genresToDisplay,
          value: widget.selectedGenreName,
          onChanged: _handleGenreChange,
          hint: 'All Genres',
        ),
      ],
    );
  }
}
