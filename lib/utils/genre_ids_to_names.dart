import '../models/general/genre_model.dart';

String genreIdsToNames(List<GenreModel> allGenres, List<int> genreIds) =>
    allGenres
        .where((g) => genreIds.contains(g.id))
        .map((g) => g.name)
        .join(', ');
